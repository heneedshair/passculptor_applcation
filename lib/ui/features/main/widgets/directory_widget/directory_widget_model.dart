import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:elementary/elementary.dart';

abstract interface class IDirectoryDrawerModel extends ElementaryModel {
  List<Keyword> filterKeywords({
    required List<Keyword> source,
    required String query,
  });
}

class DirectoryDrawerModel extends IDirectoryDrawerModel {
  @override
  List<Keyword> filterKeywords({
    required List<Keyword> source,
    required String query,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return source;

    final filteredKeywords = <Keyword>[];

    for (final keyword in source) {
      final isKeywordMatched = keyword.name.toLowerCase().contains(normalizedQuery);
      final filteredLogins = <Login>[];

      for (final login in keyword.logins) {
        final isLoginMatched = login.username.toLowerCase().contains(normalizedQuery);

        if (isKeywordMatched || isLoginMatched) {
          filteredLogins.add(Login(login.username, List<String>.from(login.websites)));
          continue;
        }

        final matchedWebsites = login.websites
            .where((website) => website.toLowerCase().contains(normalizedQuery))
            .toList();

        if (matchedWebsites.isNotEmpty) {
          filteredLogins.add(Login(login.username, matchedWebsites));
        }
      }

      if (isKeywordMatched || filteredLogins.isNotEmpty) {
        filteredKeywords.add(Keyword(keyword.name, filteredLogins));
      }
    }

    return filteredKeywords;
  }
}
