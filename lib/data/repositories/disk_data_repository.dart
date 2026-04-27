import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiskDataRepository implements IDiskDataRepository {
  DiskDataRepository._({
    required Box<Keyword> websitesBox,
    required SharedPreferences preferences,
  })  : _websitesBox = websitesBox,
        _preferences = preferences,
        _keywordsNotifier = ValueNotifier<List<Keyword>>(websitesBox.values.toList()),
        _isLoginObscuredNotifier = ValueNotifier<bool>(preferences.getBool(_PrefsKeys.isLoginObscured) ?? false),
        _isKeyObscuredNotifier = ValueNotifier<bool>(preferences.getBool(_PrefsKeys.isKeyObscured) ?? true),
        _isPasswordObscuredNotifier = ValueNotifier<bool>(preferences.getBool(_PrefsKeys.isPasswordObscured) ?? true),
        _doSaveNotifier = ValueNotifier<bool>(preferences.getBool(_PrefsKeys.doSave) ?? true),
        _encryptionTypeNotifier = ValueNotifier<EncryptionType>(
          EncryptionType.fromString(preferences.getString(_PrefsKeys.encryptionAlgorithm)),
        );

  final Box<Keyword> _websitesBox;
  final SharedPreferences _preferences;

  final ValueNotifier<List<Keyword>> _keywordsNotifier;
  final ValueNotifier<bool> _isLoginObscuredNotifier;
  final ValueNotifier<bool> _isKeyObscuredNotifier;
  final ValueNotifier<bool> _isPasswordObscuredNotifier;
  final ValueNotifier<bool> _doSaveNotifier;
  final ValueNotifier<EncryptionType> _encryptionTypeNotifier;

  static Future<IDiskDataRepository> create() async {
    final websitesBox = await Hive.openBox<Keyword>('websites');
    final preferences = await SharedPreferences.getInstance();

    return DiskDataRepository._(websitesBox: websitesBox, preferences: preferences);
  }

  @override
  ValueListenable<List<Keyword>> get keywordsListenable => _keywordsNotifier;

  @override
  Future<void> addWebsite({
    required String login,
    required String website,
    required String keyword,
  }) async {
    final maskedKeyword = _maskString(keyword);
    final keywords = _keywords;
    final savedKeyword = _getKeyword(keywords, maskedKeyword);
    final savedLogin = savedKeyword.getLogin(login)..addWebsite(website);

    savedKeyword.addNewLogin(savedLogin);
    await _saveKeyword(keywords, savedKeyword);
  }

  @override
  bool containsSameKeyword(String keyword) => _keywords.any(
        (savedKeyword) =>
            keyword.isNotEmpty &&
            savedKeyword.name.isNotEmpty &&
            savedKeyword.name[0] == keyword[0] &&
            savedKeyword.name.length != keyword.length,
      );

  @override
  Future<void> clearKeywords() async {
    await _websitesBox.clear();
    _keywordsNotifier.value = _keywords;
  }

  @override
  Future<void> deleteWebsite({
    required String website,
    required String login,
    required String keyword,
  }) async {
    final keywords = _keywords;
    final savedKeyword = _getKeyword(keywords, keyword);
    final savedLogin = savedKeyword.getLogin(login)..deleteWebsite(website);

    if (savedLogin.websites.isEmpty) {
      await deleteLogin(login: login, keyword: keyword);
      return;
    }

    await _saveKeyword(keywords, savedKeyword);
  }

  @override
  Future<void> deleteLogin({
    required String login,
    required String keyword,
  }) async {
    final keywords = _keywords;
    final savedKeyword = _getKeyword(keywords, keyword)..deleteLogin(login);

    if (savedKeyword.logins.isEmpty) {
      await deleteKeyword(keyword);
      return;
    }

    await _saveKeyword(keywords, savedKeyword);
  }

  @override
  Future<void> deleteKeyword(String keyword) async {
    final keywordIndex = _keywords.indexWhere((savedKeyword) => savedKeyword.name == keyword);

    if (keywordIndex != -1) await _websitesBox.deleteAt(keywordIndex);
    _keywordsNotifier.value = _keywords;
  }

  @override
  bool get isLoginObscured => isLoginObscuredListenable.value;

  @override
  ValueListenable<bool> get isLoginObscuredListenable => _isLoginObscuredNotifier;

  @override
  Future<void> setLoginObscured(bool value) async {
    await _preferences.setBool(_PrefsKeys.isLoginObscured, value);
    _isLoginObscuredNotifier.value = value;
  }

  @override
  bool get isKeyObscured => isKeyObscuredListenable.value;

  @override
  ValueListenable<bool> get isKeyObscuredListenable => _isKeyObscuredNotifier;

  @override
  Future<void> setKeyObscured(bool value) async {
    await _preferences.setBool(_PrefsKeys.isKeyObscured, value);
    _isKeyObscuredNotifier.value = value;
  }

  @override
  bool get isPasswordObscured => isPasswordObscuredListenable.value;

  @override
  ValueListenable<bool> get isPasswordObscuredListenable => _isPasswordObscuredNotifier;

  @override
  Future<void> setPasswordObscured(bool value) async {
    await _preferences.setBool(_PrefsKeys.isPasswordObscured, value);
    _isPasswordObscuredNotifier.value = value;
  }

  @override
  bool get doSave => doSaveListenable.value;

  @override
  ValueListenable<bool> get doSaveListenable => _doSaveNotifier;

  @override
  Future<void> setDoSave(bool value) async {
    await _preferences.setBool(_PrefsKeys.doSave, value);
    _doSaveNotifier.value = value;
  }

  @override
  String? get encryptionAlgorithm => encryptionTypeListenable.value.name;

  @override
  ValueListenable<EncryptionType> get encryptionTypeListenable => _encryptionTypeNotifier;

  @override
  Future<void> setEncryptionAlgorithm(String value) async {
    await _preferences.setString(_PrefsKeys.encryptionAlgorithm, value);
    _encryptionTypeNotifier.value = EncryptionType.fromString(value);
  }

  List<Keyword> get _keywords => _websitesBox.values.toList();

  static String _maskString(String input) {
    if (input.isEmpty) return input;
    return input[0] + '*' * (input.length - 1);
  }

  static Keyword _getKeyword(List<Keyword> keywords, String keyword) {
    return keywords.firstWhere(
      (savedKeyword) => savedKeyword.name == keyword,
      orElse: () => Keyword(keyword, <Login>[]),
    );
  }

  Future<void> _saveKeyword(List<Keyword> keywords, Keyword keyword) async {
    final keywordIndex = keywords.indexWhere((savedKeyword) => savedKeyword.name == keyword.name);

    if (keywordIndex == -1) {
      await _websitesBox.add(keyword);
      _keywordsNotifier.value = _keywords;
      return;
    }

    await _websitesBox.putAt(keywordIndex, keyword);
    _keywordsNotifier.value = _keywords;
  }
}

abstract final class _PrefsKeys {
  static const isLoginObscured = 'isLoginObscured';
  static const isKeyObscured = 'isKeyObscured';
  static const isPasswordObscured = 'isPasswordObscured';
  static const doSave = 'doSave';
  static const encryptionAlgorithm = 'encryptionAlgorithm';
}
