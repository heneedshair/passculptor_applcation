import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/inherited/directory_functions_inherited.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget/keyword_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class DirectoryDrawerWidget extends StatelessWidget {
  const DirectoryDrawerWidget({
    super.key,
    required this.listenableEntityState,
  });

  final EntityValueListenable<List<Keyword>> listenableEntityState;

  void _onBackTap(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colors.secondary,
      width: MediaQuery.of(context).size.width * 5 / 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            leading: IconButton(
              onPressed: () => _onBackTap(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: DirectFuncs.read(context)?.onClearAllTap,
              ),
            ],
            title: const Text('Сайты'),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          EntityStateNotifierBuilder(
            listenableEntityState: listenableEntityState,
            loadingBuilder: (_, __) => const SliverFillRemaining(
              hasScrollBody: false,
              child: CircularProgressIndicator(),
            ),
            builder: (_, keywords) => keywords!.isEmpty
                ? const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Список еще пуст...'),
                    )),
                  )
                : SliverPadding(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
                    sliver: SliverList.separated(
                      itemCount: keywords.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (_, index) => KeywordTileWidget(
                        keyword: keywords[index],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
