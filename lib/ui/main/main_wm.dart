import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/objects/code_generator.dart';
import 'package:code_generator_app/ui/main/main_model.dart';
import 'package:code_generator_app/ui/main/main_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract interface class IMainScreenWidgetModel implements IWidgetModel {
  TextEditingController get wordController;

  TextEditingController get keyController;

  TextEditingController get loginController;

  ValueNotifier<String> get result;

  void onEnterTap();

  void onPasswordTap();

  void onObscureKeyTap();

  void onObscureLoginTap();

  FocusNode get keywordFocusNode;

  ValueNotifier<bool> get isLoginObscured;

  ValueNotifier<bool> get isKeyObscured;

  void onDrawerTap(BuildContext context);

  BuildContext get context;

  ValueNotifier<bool> get doSave;

  void onSaveCheckTap();

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
  Future<void> onEnterTap() async {
    result.value = CodeGenerator.generate(
      _wordController.text,
      _keyController.text,
      _loginController.text,
    );

    if (doSave.value) {
      model.addWebsite(
        loginController.text,
        wordController.text,
        keyController.text,
      );

      needsDrawerUpdate = true;
      await _initDrawer();
    }
  }

  @override
  void onPasswordTap() {
    ScaffoldMessenger.of(context).clearSnackBars();
    Clipboard.setData(
      ClipboardData(text: _result.value),
    ).then(
      //TODO мб надо сделать context параметром метода
      (_) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пароль успешно скопирован!'),
        ),
      ),
    );
  }

  @override
  void onObscureKeyTap() => _isKeyObscured.value = !_isKeyObscured.value;

  @override
  void onObscureLoginTap() => _isLoginObscured.value = !_isLoginObscured.value;

  final _isLoginObscured = ValueNotifier<bool>(false);

  @override
  ValueNotifier<bool> get isLoginObscured => _isLoginObscured;

  final _isKeyObscured = ValueNotifier<bool>(true);

  @override
  ValueNotifier<bool> get isKeyObscured => _isKeyObscured;

  @override
  void onDrawerTap(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  final _doSave = ValueNotifier<bool>(true);

  @override
  ValueNotifier<bool> get doSave => _doSave;

  @override
  void onSaveCheckTap() => _doSave.value = !_doSave.value;

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

    needsDrawerUpdate = false;
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
  void onWebsiteTap({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) {
    _loginController.text = enteredLogin;
    _wordController.text = enteredWebsite;
    if (_keyController.text.length != enteredKeyword.length ||
        _keyController.text[0] != enteredKeyword[0]) {
      _keyController.text = '';
      _result.value = 'Здесь появится пароль';
      _keywordFocusNode.requestFocus();
    } else {
      onEnterTap();
    }
    _scaffoldKey.currentState?.closeEndDrawer();
  }
}
