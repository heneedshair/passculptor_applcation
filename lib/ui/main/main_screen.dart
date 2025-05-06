import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/data/provider/directory_functions_data.dart';
import 'package:code_generator_app/ui/main/main_wm.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget/directory_widget.dart';
import 'package:code_generator_app/ui/main/widgets/enter_button.dart';
import 'package:code_generator_app/ui/main/widgets/themed_text_field/key_text_field.dart';
import 'package:code_generator_app/ui/main/widgets/themed_text_field/login_text_field.dart';
import 'package:code_generator_app/ui/main/widgets/top_buttons_bar_widget.dart';
import 'package:code_generator_app/ui/main/widgets/middle_bar_widget.dart';
import 'package:code_generator_app/ui/main/widgets/password_field.dart';
import 'package:code_generator_app/ui/main/widgets/text_large_title_widget.dart';
import 'package:code_generator_app/ui/main/widgets/themed_text_field/themed_text_field.dart';
import 'package:code_generator_app/ui/widgets/decorations/logo.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MainScreen extends ElementaryWidget<IMainScreenWidgetModel> {
  const MainScreen({super.key}) : super(defaultMainScreenWidgetModelFactory);

  @override
  Widget build(IMainScreenWidgetModel wm) {
    return Scaffold(
      key: wm.scaffoldKey,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: Stack(
          children: [
            TopButtonsBarWidget(
              onSettingsTap: () => wm.onSettingsTap(),
              onDrawerTap: (BuildContext context) => wm.onDrawerTap(context),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Logo(),
                    const TextLargeTitleWidget(),
                    SizedBox(
                      height: MediaQuery.of(wm.context).size.height / 10,
                    ),
                    LoginTextField(
                      isLoginObscuredListenable: wm.isLoginObscuredListenable,
                      loginController: wm.loginController,
                      onObscureLoginTap: () => wm.onObscureLoginTap(),
                    ),
                    const SizedBox(height: 15),
                    ThemedTextField(
                      labelText: 'Название сайта',
                      prefixIcon: const Icon(Icons.web_asset),
                      controller: wm.wordController,
                    ),
                    const SizedBox(height: 15),
                    KeyTextField(
                      isKeyObscuredListenable: wm.isKeyObscuredListenable,
                      keyController: wm.keyController,
                      focusNode: wm.keywordFocusNode,
                      onObscureKeyTap: () => wm.onObscureKeyTap(),
                    ),
                    const SizedBox(height: 5),
                    MiddleBarWidget(
                      doSaveListenable: wm.doSaveListenable,
                      onSaveCheckTap: () => wm.onSaveCheckTap(),
                      onGuideTap: () => wm.onGuideTap(),
                    ),
                    const SizedBox(height: 5),
                    PasswordField(
                      result: wm.result,
                      onTap: () => wm.onPasswordTap(),
                    ),
                    const SizedBox(height: 15),
                    EnterButton(
                      listenableEntityState: wm.encryptionAlgorithmListenable,
                      onEnterTap: () => wm.onEnterTap(),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawerEdgeDragWidth: MediaQuery.of(wm.context).size.width,
      onEndDrawerChanged: (isDrawerOpened) =>
          wm.onDrawerChanged(isDrawerOpened),
      //TODO заменить на inherited
      //TODO удалить провайдер из зависимостей
      endDrawer: Provider<DirectoryFunctionsData>.value(
        value: DirectoryFunctionsData(
          onClearAllTap: () => wm.onClearAllTap(),
          onDeleteWebsite: wm.onDeleteWebsite,
          onWebsiteTap: wm.onWebsiteTap,
          onLoginLongPress: wm.onLoginLongPress,
        ),
        child: DirectoryDrawerWidget(
          listenableEntityState: wm.savedKeywordsListenable,
        ),
      ),
    );
  }
}
