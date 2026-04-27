import 'package:code_generator_app/common/extensions/build_context.dart';
import 'package:code_generator_app/data/inherited/directory_functions_inherited.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_widget_wm.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/widgets/keyword_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

//TODO вынести в отдельный елементери
class DirectoryDrawerWidget extends ElementaryWidget<IDirectoryDrawerWidgetModel> {
  const DirectoryDrawerWidget({
    super.key,
    required this.listenableEntityState,
  }) : super(defaultDirectoryDrawerWidgetModelFactory);

  final EntityValueListenable<List<Keyword>> listenableEntityState;

  @override
  Widget build(IDirectoryDrawerWidgetModel wm) {
    return Drawer(
      width: wm.context.width * 5 / 6,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          EntityStateNotifierBuilder(
            listenableEntityState: wm.isSearchModeListenable,
            builder: (_, isSearchMode) {
              final searchModeEnabled = isSearchMode ?? false;

              return SliverAppBar(
                backgroundColor: wm.context.colors.surface,
                pinned: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                leading: IconButton(
                  onPressed: wm.onBackTap,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                actions: [
                  IconButton(
                    icon: Icon(searchModeEnabled ? Icons.close : Icons.search),
                    onPressed: wm.onSearchTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline_rounded),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: DirectFuncs.read(wm.context)?.onClearAllTap,
                  ),
                ],
                title: searchModeEnabled
                    ? TextField(
                        controller: wm.searchController,
                        autofocus: true,
                        onChanged: wm.onSearchChanged,
                        decoration: const InputDecoration(
                          hintText: 'сайт/логин/ключевое слово',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      )
                    : const Text(
                        'Сайты',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              );
            },
          ),
          EntityStateNotifierBuilder(
            listenableEntityState: listenableEntityState,
            loadingBuilder: (_, __) => const SliverFillRemaining(
              hasScrollBody: false,
              child: CircularProgressIndicator(),
            ),
            builder: (_, keywords) {
              final source = keywords ?? const <Keyword>[];

              return EntityStateNotifierBuilder(
                listenableEntityState: wm.searchQueryListenable,
                builder: (_, __) {
                  final filteredKeywords = wm.filterKeywords(source);

                  return filteredKeywords.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text('Ничего не найдено'),
                            ),
                          ),
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
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
        ],
      ),
    );
  }
}
