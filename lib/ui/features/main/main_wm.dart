import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/common/utils/notification/app_notification.dart';
import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/common/utils/code_generator/i_code_generator.dart';
import 'package:code_generator_app/common/utils/navigation/app_router.dart';
import 'package:code_generator_app/data/models/password/password.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:code_generator_app/ui/features/main/main_model.dart';
import 'package:code_generator_app/ui/features/main/main_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

abstract interface class IMainScreenWidgetModel implements IWidgetModel {
  TextEditingController get wordController;

  TextEditingController get keywordController;

  TextEditingController get loginController;

  ValueNotifier<Password> get password;

  void onEnterTap();

  void onPasswordTap();

  void onObscureLoginTap();

  void onObscureKeywordTap();

  void onObscurePasswordTap();

  void onSaveCheckTap();

  ValueListenable<bool> get isLoginObscuredListenable;

  ValueListenable<bool> get isKeywordObscuredListenable;

  ValueListenable<bool> get isPasswordObscuredListenable;

  ValueListenable<bool> get doSaveListenable;

  void onDrawerTap(BuildContext context);

  FocusNode get loginFocusNode;

  FocusNode get websiteFocusNode;

  FocusNode get keywordFocusNode;

  void onAnyTexFieldChanged();

  BuildContext get context;

  void onGuideTap();

  void onWebsiteTap({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  });

  GlobalKey<ScaffoldState> get scaffoldKey;

  void onSettingsTap();

  ValueListenable<EncryptionType> get encryptionTypeListenable;

  ValueListenable<int> get passwordGenerationSuccessListenable;

  void onNextTapFromLogin();

  GlobalKey<FormState> get formKey;

  String? loginValidator(String? value);

  String? websiteValidator(String? value);

  String? keywordValidator(String? value);
}

MainScreenWidgetModel defaultMainScreenWidgetModelFactory(BuildContext context) {
  return MainScreenWidgetModel(
    MainScreenModel(context.read<IDiskDataRepository>()),
  );
}

class MainScreenWidgetModel extends WidgetModel<MainScreen, IMainScreenModel> implements IMainScreenWidgetModel {
  MainScreenWidgetModel(super.model);

  late ICodeGenerator _codeGenerator;

  @override
  void initWidgetModel() {
    _codeGenerator = ICodeGenerator(model.encryptionAlgorithm);

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _wordController.dispose();
    _keyController.dispose();
    _loginController.dispose();
    _password.dispose();
    _passwordGenerationSuccess.dispose();
    _keywordFocusNode.dispose();
    _loginFocusNode.dispose();
    _websiteFocusNode.dispose();
    super.dispose();
  }

  final _wordController = TextEditingController();

  @override
  TextEditingController get wordController => _wordController;

  final _keyController = TextEditingController();

  @override
  TextEditingController get keywordController => _keyController;

  final _loginController = TextEditingController();

  @override
  TextEditingController get loginController => _loginController;

  final _password = ValueNotifier(Password());

  @override
  ValueNotifier<Password> get password => _password;

  final _passwordGenerationSuccess = ValueNotifier(0);

  @override
  ValueListenable<int> get passwordGenerationSuccessListenable => _passwordGenerationSuccess;

  @override
  void onEnterTap() {
    if (!_formKey.currentState!.validate()) {
      _password.value = Password(label: 'Не удалось создать пароль');
      return;
    }

    final result = _codeGenerator.generate(
      _wordController.text,
      _keyController.text,
      _loginController.text,
    );
    password.value = Password(label: result, value: result);
    _passwordGenerationSuccess.value++;

    if (doSaveListenable.value) {
      unawaited(
        model.addWebsite(
          _loginController.text,
          _wordController.text,
          _keyController.text,
        ),
      );
    }

    _setPasswordToClipboard();
    AppNotification.showSnackBar(
      context: context,
      message: 'Пароль успешно создан и скопирован!',
    );
  }

  @override
  Future<void> onPasswordTap() async {
    await _setPasswordToClipboard();
    AppNotification.showSnackBar(
      // ignore: use_build_context_synchronously
      context: context,
      message: 'Пароль успешно скопирован!',
      isSuccsess: _password.value.value != null,
      unsuccessMessage: 'Пароль еще не создан',
    );
  }

  Future<void> _setPasswordToClipboard() async {
    if (_password.value.value != null) {
      await Clipboard.setData(
        ClipboardData(text: _password.value.value!),
      );
    }
  }

  @override
  void onObscureLoginTap() {
    unawaited(model.setLoginObscured(!model.isLoginObscured));
  }

  @override
  void onObscureKeywordTap() {
    unawaited(model.setKeyObscured(!model.isKeyObscured));
  }

  @override
  void onObscurePasswordTap() {
    unawaited(model.setPasswordObscured(!model.isPasswordObscured));
  }

  @override
  ValueListenable<bool> get isLoginObscuredListenable => model.isLoginObscuredListenable;

  @override
  ValueListenable<bool> get isKeywordObscuredListenable => model.isKeyObscuredListenable;

  @override
  ValueListenable<bool> get isPasswordObscuredListenable => model.isPasswordObscuredListenable;

  @override
  void onDrawerTap(BuildContext context) => Scaffold.of(context).openEndDrawer();

  @override
  ValueListenable<bool> get doSaveListenable => model.doSaveListenable;

  @override
  void onSaveCheckTap() {
    unawaited(model.setDoSave(!model.doSave));
  }

  @override
  void onGuideTap() {
    // TODO: implement onGuideTap
  }

  final FocusNode _keywordFocusNode = FocusNode();

  @override
  FocusNode get keywordFocusNode => _keywordFocusNode;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  @override
  Future<void> onWebsiteTap({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    _loginController.text = enteredLogin;
    _wordController.text = enteredWebsite;

    if (_keyController.text.length != enteredKeyword.length || _keyController.text[0] != enteredKeyword[0]) {
      _keyController.text = '';
      _password.value = Password();
      _keywordFocusNode.requestFocus();

      AppNotification.showSnackBar(
        context: context,
        message: 'Введите ключевое слово',
      );
    } else {
      onEnterTap();
    }
    _scaffoldKey.currentState?.closeEndDrawer();
  }

  @override
  Future<void> onSettingsTap() async {
    await AutoRouter.of(context).push(const SettingsRoute());
    _codeGenerator = ICodeGenerator(model.encryptionAlgorithm);
  }

  @override
  ValueListenable<EncryptionType> get encryptionTypeListenable => model.encryptionTypeListenable;

  final _loginFocusNode = FocusNode();

  @override
  FocusNode get loginFocusNode => _loginFocusNode;

  final _websiteFocusNode = FocusNode();

  @override
  FocusNode get websiteFocusNode => _websiteFocusNode;

  @override
  void onAnyTexFieldChanged() => _password.value = Password();

  @override
  void onNextTapFromLogin() => _websiteFocusNode.requestFocus();

  final _formKey = GlobalKey<FormState>();

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  String? loginValidator(String? value) {
    if (value!.isNotEmpty && value.length < 4) {
      return 'Логин короче 4 символов (и не пуст)';
    }

    return null;
  }

  @override
  String? websiteValidator(String? value) {
    if (value!.isEmpty) return 'Поле не должно быть пустым';

    if (value.length < 4) return 'Сайт должен быть не менее 4 символов';

    return null;
  }

  @override
  String? keywordValidator(String? value) {
    if (value!.isEmpty) return 'Поле не должно быть пустым';

    if (model.containsSameKeyword(value)) {
      return 'Уже есть другое слово, начинающееся на эту букву';
    }

    if (value.length < 8) return 'Слово должно быть не менее 8 символов';

    return null;
  }
}
