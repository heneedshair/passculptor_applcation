import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/inherited/directory_functions_inherited.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget/website_tile_widget.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
      onLongPress: () => DirectFuncs.read(context)?.onLoginLongPress(
        enteredLogin: login.username.isEmpty ? 'Без логина' : login.username,
        enteredKeyword: parentKeyword.name,
      ),
      child: ExpansionTile(
        backgroundColor: AppColors.backgroundColor,
        collapsedBackgroundColor: AppColors.backgroundColor,
        tilePadding: const EdgeInsets.only(left: 16 + 20, right: 24),
        initiallyExpanded: true,
        title: Text(
          login.username.isEmpty ? 'Без логина' : login.username,
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
