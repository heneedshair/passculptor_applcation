import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/ui/main/widgets/keyword_tile_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class DirectoryDrawerWidget extends StatelessWidget {
  const DirectoryDrawerWidget({
    super.key,
    required this.listenableEntityState,
    required this.onClearAllTap,
  });

  final ValueNotifier<EntityState<List<Keyword>>> listenableEntityState;
  final VoidCallback onClearAllTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 5 / 6,
      //TODO заключить список в отдельный column
      child: EntityStateNotifierBuilder(
        listenableEntityState: listenableEntityState,
        loadingBuilder: (_, __) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (_, keywords) => ListView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          children: [
            const Text(
              'Сохраненные ключевые слова:',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            ...?keywords?.map((keyword) => KeywordTileWidget(keyword: keyword)),
            TextButton(
              onPressed: () => onClearAllTap(),
              child: const Text(
                'Удалить все',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
