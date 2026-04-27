import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiskDataRepository implements IDiskDataRepository {
  DiskDataRepository({
    required Box<Keyword> websitesBox,
    required SharedPreferences preferences,
  })  : _websitesBox = websitesBox,
        _preferences = preferences;

  final Box<Keyword> _websitesBox;
  final SharedPreferences _preferences;

  @override
  Future<List<Keyword>> loadKeywords() async => _keywords;

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
        (savedKeyword) => savedKeyword.name[0] == keyword[0] && savedKeyword.name.length != keyword.length,
      );

  @override
  Future<void> clearKeywords() => _websitesBox.clear();

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
  }

  @override
  bool get isLoginObscured => _preferences.getBool(_PrefsKeys.isLoginObscured) ?? false;

  @override
  Future<void> setLoginObscured(bool value) => _preferences.setBool(_PrefsKeys.isLoginObscured, value);

  @override
  bool get isKeyObscured => _preferences.getBool(_PrefsKeys.isKeyObscured) ?? true;

  @override
  Future<void> setKeyObscured(bool value) => _preferences.setBool(_PrefsKeys.isKeyObscured, value);

  @override
  bool get isPasswordObscured => _preferences.getBool(_PrefsKeys.isPasswordObscured) ?? true;

  @override
  Future<void> setPasswordObscured(bool value) => _preferences.setBool(_PrefsKeys.isPasswordObscured, value);

  @override
  bool get doSave => _preferences.getBool(_PrefsKeys.doSave) ?? true;

  @override
  Future<void> setDoSave(bool value) => _preferences.setBool(_PrefsKeys.doSave, value);

  @override
  String? get encryptionAlgorithm => _preferences.getString(_PrefsKeys.encryptionAlgorithm);

  @override
  Future<void> setEncryptionAlgorithm(String value) => _preferences.setString(_PrefsKeys.encryptionAlgorithm, value);

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
      return;
    }

    await _websitesBox.putAt(keywordIndex, keyword);
  }
}

abstract final class _PrefsKeys {
  static const isLoginObscured = 'isLoginObscured';
  static const isKeyObscured = 'isKeyObscured';
  static const isPasswordObscured = 'isPasswordObscured';
  static const doSave = 'doSave';
  static const encryptionAlgorithm = 'encryptionAlgorithm';
}
