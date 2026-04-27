import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiskDataRepository implements IDiskDataRepository {
  DiskDataRepository._({
    required Box<Keyword> websitesBox,
    required SharedPreferences preferences,
  })  : _websitesBox = websitesBox,
        _preferences = preferences {
    _keywordsEntity.content(_keywords);
    _isLoginObscuredEntity.content(_storedIsLoginObscured);
    _isKeyObscuredEntity.content(_storedIsKeyObscured);
    _isPasswordObscuredEntity.content(_storedIsPasswordObscured);
    _doSaveEntity.content(_storedDoSave);
    _encryptionTypeEntity.content(EncryptionType.fromString(_storedEncryptionAlgorithm));
  }

  late final Box<Keyword> _websitesBox;
  late final SharedPreferences _preferences;

  final _keywordsEntity = EntityStateNotifier<List<Keyword>>();
  final _isLoginObscuredEntity = EntityStateNotifier<bool>();
  final _isKeyObscuredEntity = EntityStateNotifier<bool>();
  final _isPasswordObscuredEntity = EntityStateNotifier<bool>();
  final _doSaveEntity = EntityStateNotifier<bool>();
  final _encryptionTypeEntity = EntityStateNotifier<EncryptionType>();

  static Future<IDiskDataRepository> create() async {
    final websitesBox = await Hive.openBox<Keyword>('websites');
    final preferences = await SharedPreferences.getInstance();

    return DiskDataRepository._(websitesBox: websitesBox, preferences: preferences);
  }

  @override
  EntityValueListenable<List<Keyword>> get keywordsListenable => _keywordsEntity;

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
    _keywordsEntity.content(_keywords);
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
    _keywordsEntity.content(_keywords);
  }

  @override
  bool get isLoginObscured => isLoginObscuredListenable.value.data ?? _storedIsLoginObscured;

  @override
  EntityValueListenable<bool> get isLoginObscuredListenable => _isLoginObscuredEntity;

  @override
  Future<void> setLoginObscured(bool value) async {
    await _preferences.setBool(_PrefsKeys.isLoginObscured, value);
    _isLoginObscuredEntity.content(value);
  }

  @override
  bool get isKeyObscured => isKeyObscuredListenable.value.data ?? _storedIsKeyObscured;

  @override
  EntityValueListenable<bool> get isKeyObscuredListenable => _isKeyObscuredEntity;

  @override
  Future<void> setKeyObscured(bool value) async {
    await _preferences.setBool(_PrefsKeys.isKeyObscured, value);
    _isKeyObscuredEntity.content(value);
  }

  @override
  bool get isPasswordObscured => isPasswordObscuredListenable.value.data ?? _storedIsPasswordObscured;

  @override
  EntityValueListenable<bool> get isPasswordObscuredListenable => _isPasswordObscuredEntity;

  @override
  Future<void> setPasswordObscured(bool value) async {
    await _preferences.setBool(_PrefsKeys.isPasswordObscured, value);
    _isPasswordObscuredEntity.content(value);
  }

  @override
  bool get doSave => doSaveListenable.value.data ?? _storedDoSave;

  @override
  EntityValueListenable<bool> get doSaveListenable => _doSaveEntity;

  @override
  Future<void> setDoSave(bool value) async {
    await _preferences.setBool(_PrefsKeys.doSave, value);
    _doSaveEntity.content(value);
  }

  @override
  String? get encryptionAlgorithm => encryptionTypeListenable.value.data?.name ?? _storedEncryptionAlgorithm;

  @override
  EntityValueListenable<EncryptionType> get encryptionTypeListenable => _encryptionTypeEntity;

  @override
  Future<void> setEncryptionAlgorithm(String value) async {
    await _preferences.setString(_PrefsKeys.encryptionAlgorithm, value);
    _encryptionTypeEntity.content(EncryptionType.fromString(value));
  }

  List<Keyword> get _keywords => _websitesBox.values.toList();

  bool get _storedIsLoginObscured => _preferences.getBool(_PrefsKeys.isLoginObscured) ?? false;

  bool get _storedIsKeyObscured => _preferences.getBool(_PrefsKeys.isKeyObscured) ?? true;

  bool get _storedIsPasswordObscured => _preferences.getBool(_PrefsKeys.isPasswordObscured) ?? true;

  bool get _storedDoSave => _preferences.getBool(_PrefsKeys.doSave) ?? true;

  String? get _storedEncryptionAlgorithm => _preferences.getString(_PrefsKeys.encryptionAlgorithm);

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
      _keywordsEntity.content(_keywords);
      return;
    }

    await _websitesBox.putAt(keywordIndex, keyword);
    _keywordsEntity.content(_keywords);
  }
}

abstract final class _PrefsKeys {
  static const isLoginObscured = 'isLoginObscured';
  static const isKeyObscured = 'isKeyObscured';
  static const isPasswordObscured = 'isPasswordObscured';
  static const doSave = 'doSave';
  static const encryptionAlgorithm = 'encryptionAlgorithm';
}
