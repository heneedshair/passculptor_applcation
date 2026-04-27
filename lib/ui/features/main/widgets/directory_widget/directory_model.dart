import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary/elementary.dart';

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
  DirectoryDrawerModel(this._repository);

  final IDiskDataRepository _repository;

  @override
  Future<List<Keyword>> get keywordsList => _repository.loadKeywords();

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
  Future<void> clearAll() => _repository.clearKeywords();

  @override
  Future<void> deleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) =>
      _repository.deleteWebsite(
        website: enteredWebsite,
        login: enteredLogin,
        keyword: enteredKeyword,
      );

  @override
  Future<void> deleteLogin({
    required String enteredLogin,
    required String enteredKeyword,
  }) =>
      _repository.deleteLogin(
        login: enteredLogin,
        keyword: enteredKeyword,
      );

  @override
  Future<void> deleteKeyword(String enteredKeyword) => _repository.deleteKeyword(enteredKeyword);
}
