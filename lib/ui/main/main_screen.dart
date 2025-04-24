import 'package:code_generator_app/ui/main/main_wm.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget.dart';
import 'package:code_generator_app/ui/main/widgets/key_text_field.dart';
import 'package:code_generator_app/ui/main/widgets/login_text_field.dart';
import 'package:code_generator_app/ui/main/widgets/directory_button.dart';
import 'package:code_generator_app/ui/main/widgets/middle_bar_widget.dart';
import 'package:code_generator_app/ui/main/widgets/password_field.dart';
import 'package:code_generator_app/ui/main/widgets/text_large_title_widget.dart';
import 'package:code_generator_app/ui/main/widgets/themed_text_field.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:code_generator_app/ui/widgets/decorations/logo.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class MainScreen extends ElementaryWidget<IMainScreenWidgetModel> {
  const MainScreen({super.key}) : super(defaultMainScreenWidgetModelFactory);

  @override
  Widget build(IMainScreenWidgetModel wm) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Logo(),
                const TextLargeTitleWidget(),
                const SizedBox(height: 90),
                LoginTextField(
                  isLoginObscured: wm.isLoginObscured,
                  loginController: wm.loginController,
                  onObscureLoginTap: () => wm.onObscureLoginTap(),
                ),
                const SizedBox(height: 15),
                ThemedTextField(
                  labelText: 'Название сайта',
                  prefixIcon: const Icon(Icons.web_asset),
                  suffixIcon: const Icon(
                    Icons.bookmark_add_rounded,
                    color: AppColors.lightPrimaryColor,
                    //TODO сделать цвет изменяющийся
                  ),
                  controller: wm.wordController,
                ),
                const SizedBox(height: 15),
                KeyTextField(
                  isKeyObscured: wm.isKeyObscured,
                  keyController: wm.keyController,
                  onObscureKeyTap: () => wm.onObscureKeyTap(),
                ),
                const SizedBox(height: 5),
                MiddleBarWidget(
                  doSave: wm.doSave,
                  onSaveCheckTap: () => wm.onSaveCheckTap(),
                  onGuideTap: () => wm.onGuideTap(),
                ),
                const SizedBox(height: 5),
                PasswordField(
                  result: wm.result,
                  onTap: () => wm.onPasswordTap(),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () => wm.onEnterTap(),
                    child: const Text('Создать пароль'),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      drawerEdgeDragWidth: MediaQuery.of(wm.context).size.width,
      onEndDrawerChanged: (isDrawerOpened) =>
          wm.onDrawerChanged(isDrawerOpened),
      endDrawer: DirectoryDrawerWidget(
        listenableEntityState: wm.savedWebsitesListenable,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Builder(
        builder: (context) {
          return DirectoryButton(
            onPressed: () => wm.onDrawerTap(context),
          );
        },
      ),
    );
  }
}
