import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/provider/directory_functions_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Dismissible(
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(Icons.delete_forever_rounded),
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) =>
          context.read<DirectoryFunctionsData>().onDeleteWebsite(
                enteredKeyword: parentKeyword.name,
                enteredLogin: parentLogin.username,
                enteredWebsite: website,
              ),
      child: InkWell(
        onTap: () => context.read<DirectoryFunctionsData>().onWebsiteTap(
              enteredKeyword: parentKeyword.name,
              enteredLogin: parentLogin.username,
              enteredWebsite: website,
            ),
        child: ListTile(
          title: Text(
            website,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          leading: const Icon(Icons.web_asset_rounded, size: 20),
          minLeadingWidth: 0,
        ),
      ),
    );
  }
}
