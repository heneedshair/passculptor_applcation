import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/widgets/login_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class KeywordTileWidget extends StatelessWidget {
  const KeywordTileWidget({
    super.key,
    required this.keyword,
    required this.onLongPress,
    required this.onLoginLongPress,
    required this.onDeleteWebsite,
  });

  final Keyword keyword;
  final VoidCallback onLongPress;
  final void Function({
    required String enteredLogin,
    required String enteredKeyword,
  }) onLoginLongPress;
  final void Function({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) onDeleteWebsite;

  static final defaultShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onLongPress: onLongPress,
      child: ExpansionTile(
        backgroundColor: context.colors.primaryContainer,
        collapsedBackgroundColor: context.colors.primaryContainer,
        shape: defaultShape,
        collapsedShape: defaultShape,
        initiallyExpanded: true,
        title: Text(
          keyword.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        trailing: const Icon(Icons.key_rounded),
        subtitle: const Text('Ключевое слово'),
        children: [
          ColoredBox(
            color: context.colors.surface,
            child: Column(
              children: _generateLogins(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateLogins(BuildContext context) {
    final widgets = <Widget>[];

    for (int i = 0; i < keyword.logins.length; i++) {
      widgets.add(
        LoginTileWidget(
          login: keyword.logins[i],
          parentKeyword: keyword,
          onLongPress: onLoginLongPress,
          onDeleteWebsite: onDeleteWebsite,
        ),
      );

      final isLast = i == keyword.logins.length - 1;

      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLast ? 9 : 30,
          ),
          child: Divider(
            thickness: isLast ? 5 : 2,
            height: isLast ? 5 : 2,
            color: context.colors.primaryContainer,
          ),
        ),
      );
    }

    return widgets;
  }
}
