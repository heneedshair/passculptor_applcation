import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/provider/directory_functions_data.dart';
import 'package:code_generator_app/ui/main/widgets/keyword_tile_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectoryDrawerWidget extends StatelessWidget {
  const DirectoryDrawerWidget({
    super.key,
    required this.listenableEntityState,
  });

  final ValueNotifier<EntityState<List<Keyword>>> listenableEntityState;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 5 / 6,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Text(
              'Сохраненные сайты:',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          EntityStateNotifierBuilder(
            listenableEntityState: listenableEntityState,
            loadingBuilder: (_, __) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (_, keywords) => keywords!.isEmpty
                ? const Center(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text('Список еще пуст...'),
                  ))
                : Column(
                    children: keywords
                        .map((keyword) => KeywordTileWidget(keyword: keyword))
                        .toList(),
                  ),
          ),
          TextButton(
            onPressed: () =>
                context.read<DirectoryFunctionsData>().onClearAllTap(),
            child: const Text(
              'Удалить все',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
