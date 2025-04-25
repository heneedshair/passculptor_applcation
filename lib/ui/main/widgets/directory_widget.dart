import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

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
      child: EntityStateNotifierBuilder(
        listenableEntityState: listenableEntityState,
        loadingBuilder: (_, __) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (_, keywords) => ListView(
          children: [
            const Text('Сохраненные пароли'),
            ...?keywords?.map(
              (keyword) => ExpansionTile(
                initiallyExpanded: true,
                title: Text(keyword.name),
                children: keyword.logins
                    .map(
                      (login) => ExpansionTile(
                        title: Text(login.username),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
