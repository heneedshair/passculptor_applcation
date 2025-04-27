import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginTileWidget extends StatelessWidget {
  const LoginTileWidget({
    super.key,
    required this.login,
  });

  final Login login;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.only(left: 30),
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
      children: login.websites
          .map(
            (website) => Dismissible(
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 25),
                child: const Icon(Icons.delete_forever_rounded),
              ),
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => {},
              child: ListTile(
                title: Text(website),
              ),
            ),
          )
          .toList(),
    );
  }
}
