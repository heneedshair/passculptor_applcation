import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/common/utils/navigation/app_router.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/objects/code_generator.dart';
import 'package:code_generator_app/ui/main/main_model.dart';
import 'package:code_generator_app/ui/main/main_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IMainScreenWidgetModel implements IWidgetModel {
  TextEditingController get wordController;

  TextEditingController get keyController;

  TextEditingController get loginController;

  ValueNotifier<String> get result;

  void onEnterTap();

  void onPasswordTap();

  void onObscureLoginTap();

  void onObscureKeyTap();

  void onSaveCheckTap();

  ValueNotifier<EntityState<bool>> get isLoginObscuredListenable;

  ValueNotifier<EntityState<bool>> get isKeyObscuredListenable;

  ValueNotifier<EntityState<bool>> get doSaveListenable;

  void onDrawerTap(BuildContext context);

  FocusNode get keywordFocusNode;

  BuildContext get context;

  void onGuideTap();

  ValueNotifier<EntityState<List<Keyword>>> get savedKeywordsListenable;

  void onDrawerChanged(bool isDrawerOpened);

  void onClearAllTap();

  void onDeleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  });

  void onWebsiteTap({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  });

  GlobalKey<ScaffoldState> get scaffoldKey;

  void onSettingsTap();
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

  late final SharedPreferences _prefs;

  @override
  Future<void> initWidgetModel() async {
    _savedKeywordsEntity.loading();

    _prefs = await SharedPreferences.getInstance();

    _initEntityStates();

    super.initWidgetModel();
  }

  final _wordController = TextEditingController();

  @override
  TextEditingController get wordController => _wordController;

  final _keyController = TextEditingController();

  @override
  TextEditingController get keyController => _keyController;

  final _loginController = TextEditingController();

  @override
  TextEditingController get loginController => _loginController;

  final _result = ValueNotifier('Здесь появится пароль');

  @override
  ValueNotifier<String> get result => _result;

  @override
  void onEnterTap() {
    result.value = CodeGenerator.generate(
      _wordController.text,
      _keyController.text,
      _loginController.text,
    );

    if (doSaveListenable.value.data!) {
      model.addWebsite(
        loginController.text,
        wordController.text,
        keyController.text,
      );

      needsDrawerUpdate = true;
    }
  }

  @override
  Future<void> onPasswordTap() async {
    await Clipboard.setData(ClipboardData(text: _result.value));

    _showSnackBar('Пароль успешно скопирован!');
  }

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
  void onObscureKeyTap() {
    _isKeyObscuredEntity.content(!_isKeyObscuredEntity.value.data!);
    _prefs.setBool('isKeyObscured', _isKeyObscuredEntity.value.data!);
  }

  final _isLoginObscuredEntity = EntityStateNotifier<bool>();

  @override
  ValueNotifier<EntityState<bool>> get isLoginObscuredListenable =>
      _isLoginObscuredEntity;

  final _isKeyObscuredEntity = EntityStateNotifier<bool>();

  @override
  ValueNotifier<EntityState<bool>> get isKeyObscuredListenable =>
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
  ValueNotifier<EntityState<List<Keyword>>> get savedKeywordsListenable =>
      _savedKeywordsEntity;

  @override
  Future<void> onClearAllTap() async {
    await model.clearAll();
    await _initDrawer();
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
      _showSnackBar('Пароль успешно создан!');
    }
    _scaffoldKey.currentState?.closeEndDrawer();
  }

  @override
  void onSettingsTap() => AutoRouter.of(context).push(const SettingsRoute());
}
