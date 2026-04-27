import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:elementary/elementary.dart';
import 'package:hive/hive.dart';

abstract interface class IMainScreenModel extends ElementaryModel {
  Future<void> addWebsite(String login, String website, String key);

  bool containsSameKeyword(String enteredKeyword);
}

class MainScreenModel extends IMainScreenModel {
  MainScreenModel();

  //TODO Удалить и сделать общение с памятью через репозиторий
  @override
  Future<void> addWebsite(
    String enteredLogin,
    String enteredWebsite,
    String enteredKeyword,
  ) async {
    enteredKeyword = _maskString(enteredKeyword);

    final websites = Hive.box<Keyword>('websites');
    final keywords = websites.values.toList();
    final keyword = _getKeyword(keywords, enteredKeyword);
    final login = keyword.getLogin(enteredLogin)..addWebsite(enteredWebsite);

    keyword.addNewLogin(login);
    await _updateBox(websites, keywords, keyword);
  }

  @override
  bool containsSameKeyword(String enteredKeyword) {
    final websites = Hive.box<Keyword>('websites');
    final keywords = websites.values.toList();

    return keywords.any(
      (keyword) => keyword.name[0] == enteredKeyword[0] && keyword.name.length != enteredKeyword.length,
    );
  }

  static String _maskString(String input) {
    if (input.isEmpty) return input;
    return input[0] + '*' * (input.length - 1);
  }

  static Keyword _getKeyword(List<Keyword> keywords, String enteredKeyword) {
    return keywords.firstWhere(
      (keyword) => keyword.name == enteredKeyword,
      orElse: () => Keyword(enteredKeyword, <Login>[]),
    );
  }

  static Future<void> _updateBox(
    Box<Keyword> websites,
    List<Keyword> keywords,
    Keyword keyword,
  ) async {
    final keywordIndex = keywords.indexWhere((item) => item.name == keyword.name);

    if (keywordIndex == -1) {
      await websites.add(keyword);
      return;
    }

    await websites.putAt(keywordIndex, keyword);
  }
}
