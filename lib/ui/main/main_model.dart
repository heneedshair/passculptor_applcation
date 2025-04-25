import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:elementary/elementary.dart';
import 'package:hive/hive.dart';

abstract interface class IMainScreenModel extends ElementaryModel {
  void addWebsite(String login, String website, String key);

  List<Keyword> get keywordsList;

  void clearAll();
}

class MainScreenModel extends IMainScreenModel {
  MainScreenModel();

  @override
  void addWebsite(
      String enteredLogin, String enteredWebsite, String enteredKeyword) {
    if (enteredLogin == '') enteredLogin = 'Без логина';
    enteredKeyword = _maskString(enteredKeyword);

    final websites = Hive.box<Keyword>('websites');
    final List<Keyword> keywords = websites.values.toList();

    // Ищем ключевое слово
    Keyword? keyword = keywords.firstWhere(
      (k) => k.name == enteredKeyword,
      orElse: () => Keyword(enteredKeyword, []),
    );

    // Ищем логин в ключевом слове
    Login? login = keyword.logins.firstWhere(
      (l) => l.username == enteredLogin,
      orElse: () => Login(enteredLogin, []),
    );

    // Добавляем сайт, если его ещё нет
    if (!login.websites.contains(enteredWebsite)) {
      login.websites.add(enteredWebsite);
    }

    // Обновляем логин в ключевом слове
    if (!keyword.logins.any((l) => l.username == enteredLogin)) {
      keyword.logins.add(login);
    }

    // Обновляем ключевое слово в Box
    final int keywordIndex =
        keywords.indexWhere((k) => k.name == enteredKeyword);
    if (keywordIndex != -1) {
      websites.putAt(keywordIndex, keyword); // Обновляем существующее
    } else {
      websites.add(keyword); // Добавляем новое
    }
  }

  static String _maskString(String input) {
    if (input.isEmpty) return input;
    return input[0] + '*' * (input.length - 1);
  }

  @override
  List<Keyword> get keywordsList {
    final websites = Hive.box<Keyword>('websites');
    return websites.values.toList();
  }
  
  @override
  void clearAll() {
    final websites = Hive.box<Keyword>('websites');
    websites.clear();
  }
}
