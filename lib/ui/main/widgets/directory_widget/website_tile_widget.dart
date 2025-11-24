import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/inherited/directory_functions_inherited.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget/custom_dismissible_widget.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WebsiteTileWidget extends StatelessWidget {
  const WebsiteTileWidget({
    super.key,
    required this.website,
    required this.parentLogin,
    required this.parentKeyword,
  });

  final String website;
  final Login parentLogin;
  final Keyword parentKeyword;

  @override
  Widget build(BuildContext context) {
    return CustomDismissibleWidget(
      onDismissed: (_) => DirectFuncs.read(context)?.onDeleteWebsite(
        enteredWebsite: website,
        enteredLogin: parentLogin.username,
        enteredKeyword: parentKeyword.name,
      ),
      child: Material(
        color: AppColors.backgroundColor,
        child: InkWell(
          onLongPress: () {},
          onTap: () => DirectFuncs.read(context)?.onWebsiteTap(
            enteredKeyword: parentKeyword.name,
            enteredLogin: parentLogin.username,
            enteredWebsite: website,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 16 + 20 + 10),
            title: Text(website),
            leading: const Icon(
              Icons.web_asset_rounded,
              size: 20,
            ),
            minLeadingWidth: 0,
          ),
        ),
      ),
    );
  }
}
