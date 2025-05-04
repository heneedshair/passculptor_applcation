import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget/website_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

//TODO объединить два шаблона в один с keywordWidget
class LoginTileWidget extends StatelessWidget {
  const LoginTileWidget({
    super.key,
    required this.login,
    required this.parentKeyword,
  });

  final Login login;
  final Keyword parentKeyword;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          onConfirmTap: () {},
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: const EdgeInsets.only(left: 10),
        title: Text(
          login.username,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text(
          'Логин',
          style: TextStyle(color: AppColors.grayColor),
        ),
        trailing: const Icon(Icons.account_circle_rounded),
        children: login.websites
            .map((website) => WebsiteTileWidget(
                  website: website,
                  parentLogin: login,
                  parentKeyword: parentKeyword,
                ))
            .toList(),
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    this.content = 'Вы уверены, что хотите удалить этот элемент?',
    required this.onConfirmTap,
  });

  final String content;
  final VoidCallback onConfirmTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content),
      contentTextStyle: const TextStyle(
        fontSize: 16,
        height: 1.5,
      ),
      contentPadding: const EdgeInsets.only(
        top: 25,
        right: 30,
        left: 30,
        bottom: 3,
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 8),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          child: const Text('Отмена'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(
          height: 30,
          child: VerticalDivider(thickness: 1, color: AppColors.grayColor),
        ),
        TextButton(
          child: const Text(
            'Удалить',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => onConfirmTap(),
        ),
      ],
    );
  }
}
