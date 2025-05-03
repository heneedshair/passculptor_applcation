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

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        keyword.name,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: const Text('Ключевое слово'),
      trailing: const Icon(Icons.key_rounded),
      children: [
        Container(
          padding: const EdgeInsets.only(left: 30),
          color: AppColors.backgroundColor,
          child: Column(
            children: keyword.logins
                .map((login) => LoginTileWidget(
                      login: login,
                      parentKeyword: keyword,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
