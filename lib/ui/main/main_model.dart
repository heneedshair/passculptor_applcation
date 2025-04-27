import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:elementary/elementary.dart';
import 'package:hive/hive.dart';

abstract interface class IMainScreenModel extends ElementaryModel {
  void addWebsite(String login, String website, String key);

  Future<List<Keyword>> get keywordsList;

  Future<void> clearAll();

  Future<void> deleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  });

  Future<void> deleteLogin({
    required String enteredLogin,
    required String enteredKeyword,
  });
}

class MainScreenModel extends IMainScreenModel {
  MainScreenModel();

  @override
  Future<void> addWebsite(
    String enteredLogin,
    String enteredWebsite,
    String enteredKeyword,
  ) async {
    if (enteredLogin == '') enteredLogin = 'Без логина';
    enteredKeyword = _maskString(enteredKeyword);

    final websites = Hive.box<Keyword>('websites');
    final List<Keyword> keywords = websites.values.toList();

    Keyword? keyword = _getKeyword(keywords, enteredKeyword);
    Login? login = keyword.getLogin(enteredLogin);

    login.addWebsite(enteredWebsite);

    // Обновляем логин в ключевом слове
    keyword.addNewLogin(login);

    // Обновляем ключевое слово в Box
    await _updateBox(websites, keywords, keyword);
  }

  static String _maskString(String input) {
    if (input.isEmpty) return input;
    return input[0] + '*' * (input.length - 1);
  }

  static Keyword _getKeyword(List<Keyword> keywords, String enteredKeyword) {
    return keywords.firstWhere(
      (k) => k.name == enteredKeyword,
      orElse: () => Keyword(enteredKeyword, []),
    );
  }

  /// Обновляем ключевое слово в Box.
  static Future<void> _updateBox(
    Box<Keyword> websites,
    List<Keyword> keywords,
    Keyword keyword,
  ) async {
    final int keywordIndex = keywords.indexWhere((k) {
      return k.name == keyword.name;
    });
    if (keywordIndex != -1) {
      await websites.putAt(keywordIndex, keyword); // Обновляем существующее
    } else {
      await websites.add(keyword); // Добавляем новое
    }
  }

  @override
  Future<List<Keyword>> get keywordsList async {
    final websites = await Hive.openBox<Keyword>('websites');
    return websites.values.toList();
  }

  @override
  Future<void> clearAll() async {
    final websites = Hive.box<Keyword>('websites');
    await websites.clear();
  }

  @override
  Future<void> deleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    final websites = Hive.box<Keyword>('websites');
    final List<Keyword> keywords = websites.values.toList();

    Keyword keyword = _getKeyword(keywords, enteredKeyword);
    Login login = keyword.getLogin(enteredLogin);
    login.deleteWebsite(enteredWebsite);

    // Удаление при пустом списке сайтов.
    if (login.websites.isEmpty) {
      await deleteLogin(
        enteredLogin: enteredLogin,
        enteredKeyword: enteredKeyword,
      );
    }
    await _updateBox(websites, keywords, keyword);
  }

  @override
  Future<void> deleteLogin({
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    final websites = Hive.box<Keyword>('websites');
    final List<Keyword> keywords = websites.values.toList();

    Keyword keyword = _getKeyword(keywords, enteredKeyword);

    keyword.deleteLogin(enteredLogin);

    await _updateBox(websites, keywords, keyword);
  }
}
