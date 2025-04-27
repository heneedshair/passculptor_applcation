import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/ui/main/widgets/website_tile_widget.dart';
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
    return ExpansionTile(
      initiallyExpanded: true,
      // childrenPadding: const EdgeInsets.only(left: 30),
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
    );
  }
}
