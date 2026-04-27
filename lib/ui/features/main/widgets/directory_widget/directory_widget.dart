import 'package:code_generator_app/common/extensions/build_context.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_widget_wm.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/widgets/keyword_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class DirectoryDrawerWidget extends ElementaryWidget<IDirectoryDrawerWidgetModel> {
  const DirectoryDrawerWidget({super.key}) : super(defaultDirectoryDrawerWidgetModelFactory);

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
          ValueListenableBuilder(
            valueListenable: wm.isSearchModeListenable,
            builder: (_, isSearchMode, __) {
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
                    icon: Icon(isSearchMode ? Icons.close : Icons.search),
                    onPressed: wm.onSearchTap,
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline_rounded),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: wm.onClearAllTap,
                  ),
                ],
                title: isSearchMode
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
            listenableEntityState: wm.keywordsListenable,
            loadingBuilder: (_, __) => const SliverFillRemaining(
              hasScrollBody: false,
              child: CircularProgressIndicator(),
            ),
            builder: (_, keywords) => keywords == null || keywords.isEmpty
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
                      itemCount: keywords.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 15),
                      itemBuilder: (_, index) {
                        final keyword = keywords[index];

                        return KeywordTileWidget(
                          keyword: keyword,
                          onLongPress: () => wm.onKeywordLongPress(keyword.name),
                          onLoginLongPress: wm.onLoginLongPress,
                          onDeleteWebsite: wm.onDeleteWebsite,
                        );
                      },
                    ),
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 25)),
        ],
      ),
    );
  }
}
