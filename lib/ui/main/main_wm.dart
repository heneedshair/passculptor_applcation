import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/common/notifications/app_notification.dart/app_notification.dart';
import 'package:code_generator_app/common/objects/code_generator/code_generator_types.dart';
import 'package:code_generator_app/common/objects/code_generator/i_code_generator.dart';
import 'package:code_generator_app/common/utils/navigation/app_router.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/ui/main/main_model.dart';
import 'package:code_generator_app/ui/main/main_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IMainScreenWidgetModel implements IWidgetModel {
  TextEditingController get wordController;

  TextEditingController get keywordController;

  TextEditingController get loginController;

  ValueNotifier<String> get result;

  void onEnterTap();

  void onPasswordTap();

  void onObscureLoginTap();

  void onObscureKeywordTap();

  void onSaveCheckTap();

  ValueNotifier<EntityState<bool>> get isLoginObscuredListenable;

  ValueNotifier<EntityState<bool>> get isKeywordObscuredListenable;

  ValueNotifier<EntityState<bool>> get doSaveListenable;

  void onDrawerTap(BuildContext context);

  FocusNode get loginFocusNode;

  FocusNode get websiteFocusNode;

  FocusNode get keywordFocusNode;

  void onTapOutsideField();

  BuildContext get context;

  void onGuideTap();

  EntityValueListenable<List<Keyword>> get savedKeywordsListenable;

  void onDrawerChanged(bool isDrawerOpened);

  void onClearAllTap();

  Future<void> onDeleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  });

  void onWebsiteTap({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  });

  Future<void> onLoginLongPress({
    required String enteredLogin,
    required String enteredKeyword,
  });

  GlobalKey<ScaffoldState> get scaffoldKey;

  void onSettingsTap();

  ValueNotifier<EntityState<EncryptionType>> get encryptionTypeListenable;

  Future<void> onKeywordLongPress(String enteredKeyword);

  void onNextTapFromLogin();

  GlobalKey<FormState> get formKey;

  String? loginValidator(String? value);

  String? websiteValidator(String? value);

  String? keywordValidator(String? value);
}

MainScreenWidgetModel defaultMainScreenWidgetModelFactory(
    BuildContext context) {
  return MainScreenWidgetModel(
    MainScreenModel(),
  );
}

class MainScreenWidgetModel extends WidgetModel<MainScreen, IMainScreenModel>
    implements IMainScreenWidgetModel {
  MainScreenWidgetModel(super.model);

  //TODO сделать через репозиторий в model
  late final SharedPreferences _prefs;

  late ICodeGenerator _codeGenerator;

  @override
  Future<void> initWidgetModel() async {
    _savedKeywordsEntity.loading();

    _prefs = await SharedPreferences.getInstance();

    _initEntityStates();

    _initEncryptionAlgorithm();

    super.initWidgetModel();
  }

  void _initEncryptionAlgorithm() {
    _encryptionTypeEntity.loading();

    //TODO переименовать encryptionAlgorithm => encryptionType
    final String? encryptionType = _prefs.getString('encryptionAlgorithm');
    _codeGenerator = ICodeGenerator(encryptionType);

    _encryptionTypeEntity.content(_codeGenerator.type);
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

  final _result = ValueNotifier('Здесь появится пароль');

  @override
  ValueNotifier<String> get result => _result;

  @override
  void onEnterTap() {
    if (!_formKey.currentState!.validate()) {
      result.value = 'Не удалось создать пароль';
      return;
    }

    result.value = _codeGenerator.generate(
      _wordController.text,
      _keyController.text,
      _loginController.text,
    );

    if (doSaveListenable.value.data!) {
      model.addWebsite(
        _loginController.text,
        _wordController.text,
        _keyController.text,
      );

      needsDrawerUpdate = true;
    }

    _setPasswordToClipboard();
    _showSnackBar('Пароль успешно создан и скопирован!');
  }

  @override
  Future<void> onPasswordTap() async {
    await _setPasswordToClipboard();
    _showSnackBar('Пароль успешно скопирован!');
  }

  Future<void> _setPasswordToClipboard() async =>
      await Clipboard.setData(ClipboardData(text: _result.value));

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void onObscureLoginTap() {
    _isLoginObscuredEntity.content(!_isLoginObscuredEntity.value.data!);
    _prefs.setBool('isLoginObscured', _isLoginObscuredEntity.value.data!);
  }

  @override
  void onObscureKeywordTap() {
    _isKeyObscuredEntity.content(!_isKeyObscuredEntity.value.data!);
    _prefs.setBool('isKeyObscured', _isKeyObscuredEntity.value.data!);
  }

  final _isLoginObscuredEntity = EntityStateNotifier<bool>();

  @override
  ValueNotifier<EntityState<bool>> get isLoginObscuredListenable =>
      _isLoginObscuredEntity;

  final _isKeyObscuredEntity = EntityStateNotifier<bool>();

  @override
  ValueNotifier<EntityState<bool>> get isKeywordObscuredListenable =>
      _isKeyObscuredEntity;

  @override
  void onDrawerTap(BuildContext context) =>
      Scaffold.of(context).openEndDrawer();

  final _doSaveEntity = EntityStateNotifier<bool>();

  @override
  ValueNotifier<EntityState<bool>> get doSaveListenable => _doSaveEntity;

  @override
  void onSaveCheckTap() {
    _doSaveEntity.content(!_doSaveEntity.value.data!);
    _prefs.setBool('doSave', _doSaveEntity.value.data!);
  }

  void _initEntityStates() {
    _isLoginObscuredEntity.loading();
    _isKeyObscuredEntity.loading();
    _doSaveEntity.loading();

    _isLoginObscuredEntity.content(_prefs.getBool('isLoginObscured') ?? false);
    _isKeyObscuredEntity.content(_prefs.getBool('isKeyObscured') ?? true);
    _doSaveEntity.content(_prefs.getBool('doSave') ?? true);
  }

  @override
  void onGuideTap() {
    // TODO: implement onGuideTap
  }

  @override
  Future<void> onDrawerChanged(bool isDrawerOpened) async {
    if (isDrawerOpened && needsDrawerUpdate) {
      await _initDrawer();
    }
  }

  Future<void> _initDrawer() async {
    _savedKeywordsEntity.loading();
    // await Future.delayed(const Duration(seconds: 1));

    try {
      _savedKeywordsEntity.content(await model.keywordsList);
    } on Exception {
      _savedKeywordsEntity.error();
    }
  }

  bool needsDrawerUpdate = true;

  final _savedKeywordsEntity = EntityStateNotifier<List<Keyword>>();

  @override
  EntityValueListenable<List<Keyword>> get savedKeywordsListenable =>
      _savedKeywordsEntity;

  @override
  Future<void> onClearAllTap() async {
    await AppNotification.showConfirmDialog(
      context: context,
      content: 'Вы уверены что хотите очистить список?',
      onConfirmTap: () async {
        await model.clearAll();
        await _initDrawer();
      },
    );
  }

  @override
  Future<void> onDeleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    await model.deleteWebsite(
      enteredWebsite: enteredWebsite,
      enteredLogin: enteredLogin,
      enteredKeyword: enteredKeyword,
    );
    await _initDrawer();
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

    if (_keyController.text.length != enteredKeyword.length ||
        _keyController.text[0] != enteredKeyword[0]) {
      _keyController.text = '';
      _result.value = 'Здесь появится пароль';
      _keywordFocusNode.requestFocus();
      _showSnackBar('Введите ключевое слово');
    } else {
      onEnterTap();
    }
    _scaffoldKey.currentState?.closeEndDrawer();
  }

  @override
  Future<void> onLoginLongPress({
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    await AppNotification.showConfirmDialog(
      context: context,
      content: 'Вы уверены что хотите удалить логин $enteredLogin?',
      onConfirmTap: () async {
        await model.deleteLogin(
          enteredLogin: enteredLogin,
          enteredKeyword: enteredKeyword,
        );
        await _initDrawer();
      },
    );
  }

  @override
  Future<void> onSettingsTap() async {
    await AutoRouter.of(context).push(SettingsRoute(
      initialEncryptionType: _encryptionTypeEntity.value.data!,
    ));

    _initEncryptionAlgorithm();
  }

  final _encryptionTypeEntity = EntityStateNotifier<EncryptionType>();

  @override
  ValueNotifier<EntityState<EncryptionType>> get encryptionTypeListenable =>
      _encryptionTypeEntity;

  @override
  Future<void> onKeywordLongPress(String enteredKeyword) async {
    await AppNotification.showConfirmDialog(
      context: context,
      content: 'Вы уверены что хотите удалить слово $enteredKeyword?',
      onConfirmTap: () async {
        await model.deleteKeyword(enteredKeyword);
        await _initDrawer();
      },
    );
  }

  final _loginFocusNode = FocusNode();

  @override
  FocusNode get loginFocusNode => _loginFocusNode;

  final _websiteFocusNode = FocusNode();

  @override
  FocusNode get websiteFocusNode => _websiteFocusNode;

  @override
  void onTapOutsideField() => FocusManager.instance.primaryFocus?.unfocus();

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

    if (value.length < 8) return 'Слово должно быть не менее 8 символов';

    if (model.containsSameKeyword(value)) {
      return 'Уже есть слово, начинающееся на эту букву';
    }

    return null;
  }
}
