import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:elementary/elementary.dart';
import 'package:hive/hive.dart';

abstract interface class IDirectoryDrawerModel extends ElementaryModel {
  Future<List<Keyword>> get keywordsList;

  List<Keyword> filterKeywords({
    required List<Keyword> source,
    required String query,
  });

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

  Future<void> deleteKeyword(String enteredKeyword);
}

class DirectoryDrawerModel extends IDirectoryDrawerModel {
  @override
  Future<List<Keyword>> get keywordsList async {
    final websites = await Hive.openBox<Keyword>('websites');
    return websites.values.toList();
  }

  @override
  List<Keyword> filterKeywords({
    required List<Keyword> source,
    required String query,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return source;

    return source
        .map((keyword) {
          final isKeywordMatched = keyword.name.toLowerCase().contains(normalizedQuery);
          final filteredLogins = <Login>[];

          for (final login in keyword.logins) {
            final isLoginMatched = login.username.toLowerCase().contains(normalizedQuery);

            if (isKeywordMatched || isLoginMatched) {
              filteredLogins.add(Login(login.username, List<String>.from(login.websites)));
              continue;
            }

            final matchedWebsites =
                login.websites.where((website) => website.toLowerCase().contains(normalizedQuery)).toList();

            if (matchedWebsites.isNotEmpty) {
              filteredLogins.add(Login(login.username, matchedWebsites));
            }
          }

          if (isKeywordMatched || filteredLogins.isNotEmpty) {
            return Keyword(keyword.name, filteredLogins);
          }

          return null;
        })
        .nonNulls
        .toList();
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
    final keywords = websites.values.toList();
    final keyword = _getKeyword(keywords, enteredKeyword);
    final login = keyword.getLogin(enteredLogin)..deleteWebsite(enteredWebsite);

    if (login.websites.isEmpty) {
      await deleteLogin(
        enteredLogin: enteredLogin,
        enteredKeyword: enteredKeyword,
      );
      return;
    }

    await _updateBox(websites, keywords, keyword);
  }

  @override
  Future<void> deleteLogin({
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    final websites = Hive.box<Keyword>('websites');
    final keywords = websites.values.toList();
    final keyword = _getKeyword(keywords, enteredKeyword)..deleteLogin(enteredLogin);

    if (keyword.logins.isEmpty) {
      await deleteKeyword(enteredKeyword);
      return;
    }

    await _updateBox(websites, keywords, keyword);
  }

  @override
  Future<void> deleteKeyword(String enteredKeyword) async {
    final websites = Hive.box<Keyword>('websites');
    final keywords = websites.values.toList();
    final keywordIndex = keywords.indexWhere((keyword) => keyword.name == enteredKeyword);

    if (keywordIndex != -1) {
      await websites.deleteAt(keywordIndex);
    }
  }

  static Keyword _getKeyword(List<Keyword> keywords, String enteredKeyword) {
    return keywords.firstWhere(
      (keyword) => keyword.name == enteredKeyword,
      orElse: () => Keyword(enteredKeyword, []),
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
