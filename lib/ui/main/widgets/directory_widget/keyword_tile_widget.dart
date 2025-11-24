import 'package:code_generator_app/data/inherited/directory_functions_inherited.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget/login_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class KeywordTileWidget extends StatelessWidget {
  const KeywordTileWidget({
    super.key,
    required this.keyword,
  });

  final Keyword keyword;

  static final defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onLongPress: () => DirectFuncs.read(context)?.onKeywordLongPress(keyword.name),
      child: ExpansionTile(
        backgroundColor: AppColors.appBarColor,
        collapsedBackgroundColor: AppColors.appBarColor,
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
          // TODO убрать контейнер
          Container(
            color: AppColors.backgroundColor,
            child: Column(
              children: _generateLogins(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateLogins() {
    final widgets = <Widget>[];

    for (int i = 0; i < keyword.logins.length; i++) {
      widgets.add(
        LoginTileWidget(
          login: keyword.logins[i],
          parentKeyword: keyword,
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
            color: AppColors.appBarColor,
            radius: BorderRadius.circular(20),
          ),
        ),
      );
    }

    return widgets;
  }
}
