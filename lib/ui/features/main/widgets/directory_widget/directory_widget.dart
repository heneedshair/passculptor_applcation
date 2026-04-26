import 'package:code_generator_app/data/inherited/directory_functions_inherited.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/keyword_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

//TODO вынести в отдельный елементери
class DirectoryDrawerWidget extends StatefulWidget {
  const DirectoryDrawerWidget({
    super.key,
    required this.listenableEntityState,
  });

  final EntityValueListenable<List<Keyword>> listenableEntityState;

  @override
  State<DirectoryDrawerWidget> createState() => _DirectoryDrawerWidgetState();
}

class _DirectoryDrawerWidgetState extends State<DirectoryDrawerWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearchMode = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBackTap(BuildContext context) => Navigator.pop(context);

  void _toggleSearchMode() {
    setState(() {
      _isSearchMode = !_isSearchMode;
      if (!_isSearchMode) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  List<Keyword> _filterKeywords(List<Keyword> source) {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return source;

    final filtered = <Keyword>[];

    for (final keyword in source) {
      final keywordMatches = keyword.name.toLowerCase().contains(query);
      final filteredLogins = <Login>[];

      for (final login in keyword.logins) {
        final loginMatches = login.username.toLowerCase().contains(query);

        if (keywordMatches || loginMatches) {
          filteredLogins.add(Login(login.username, List<String>.from(login.websites)));
          continue;
        }

        final matchedWebsites = login.websites.where((website) => website.toLowerCase().contains(query)).toList();

        if (matchedWebsites.isNotEmpty) {
          filteredLogins.add(Login(login.username, matchedWebsites));
        }
      }

      if (keywordMatches || filteredLogins.isNotEmpty) {
        filtered.add(Keyword(keyword.name, filteredLogins));
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 5 / 6,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: context.colors.surface,
            pinned: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            leading: IconButton(
              onPressed: () => _onBackTap(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            actions: [
              IconButton(
                icon: Icon(_isSearchMode ? Icons.close : Icons.search),
                onPressed: _toggleSearchMode,
              ),
              IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: DirectFuncs.read(context)?.onClearAllTap,
              ),
            ],
            title: _isSearchMode
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: _onSearchChanged,
                    decoration: const InputDecoration(
                      hintText: '����� �� ������, ������� � ������',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  )
                : const Text(
                    'Сайты',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
          ),
          EntityStateNotifierBuilder(
            listenableEntityState: widget.listenableEntityState,
            loadingBuilder: (_, __) => const SliverFillRemaining(
              hasScrollBody: false,
              child: CircularProgressIndicator(),
            ),
            builder: (_, keywords) {
              final filteredKeywords = _filterKeywords(keywords ?? []);

              return filteredKeywords.isEmpty
                  ? const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text('Ничего не найдено'),
                      )),
                    )
                  : SliverPadding(
                      padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
                      sliver: SliverList.separated(
                        itemCount: filteredKeywords.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        itemBuilder: (_, index) => KeywordTileWidget(
                          keyword: filteredKeywords[index],
                        ),
                      ),
                    );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
        ],
      ),
    );
  }
}
