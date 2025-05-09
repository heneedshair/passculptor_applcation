import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/data/inherited/directory_functions_inherited.dart';
import 'package:code_generator_app/data/inherited/text_fields_functions_inherited.dart';
import 'package:code_generator_app/ui/main/main_wm.dart';
import 'package:code_generator_app/ui/main/widgets/directory_widget/directory_widget.dart';
import 'package:code_generator_app/ui/main/widgets/enter_button.dart';
import 'package:code_generator_app/ui/main/widgets/themed_text_field/obscurable_text_field.dart';
import 'package:code_generator_app/ui/main/widgets/themed_text_field/themed_text_field.dart';
import 'package:code_generator_app/ui/main/widgets/top_buttons_bar_widget.dart';
import 'package:code_generator_app/ui/main/widgets/middle_bar_widget.dart';
import 'package:code_generator_app/ui/main/widgets/password_field.dart';
import 'package:code_generator_app/ui/main/widgets/text_large_title_widget.dart';
import 'package:code_generator_app/ui/widgets/decorations/logo.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

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
                reverse: true,
                child: FieldsFuncs(
                  onTapOutsideField: () => wm.onTapOutsideField(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 25),
                      const Logo(),
                      const TextLargeTitleWidget(),
                      SizedBox(
                        height: MediaQuery.of(wm.context).size.height / 11,
                      ),
                      ObscurableTextField(
                        listenableEntityState: wm.isLoginObscuredListenable,
                        controller: wm.loginController,
                        focusNode: wm.loginFocusNode,
                        onObscureTap: () => wm.onObscureLoginTap(),
                        onFieldSubmitted: () => wm.onNextTapFromLogin(),
                        labelText: 'Логин (необязательно)',
                        prefixIcon: const Icon(Icons.account_circle_rounded),
                      ),
                      const SizedBox(height: 15),
                      ThemedTextField(
                        controller: wm.wordController,
                        focusNode: wm.websiteFocusNode,
                        textInputAction: TextInputAction.next,
                        labelText: 'Сайт/приложение',
                        prefixIcon: const Icon(Icons.web_asset_rounded),
                      ),
                      const SizedBox(height: 15),
                      ObscurableTextField(
                        listenableEntityState: wm.isKeywordObscuredListenable,
                        controller: wm.keywordController,
                        focusNode: wm.keywordFocusNode,
                        onObscureTap: () => wm.onObscureKeywordTap(),
                        onFieldSubmitted: () => wm.onEnterTap(),
                        labelText: 'Ключевое слово',
                        prefixIcon: const Icon(Icons.key_rounded),
                        textInputAction: TextInputAction.done,
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
            ),
          ],
        ),
      ),
      drawerEdgeDragWidth: MediaQuery.of(wm.context).size.width,
      onEndDrawerChanged: (isDrawerOpened) =>
          wm.onDrawerChanged(isDrawerOpened),
      //TODO мб есть смысл просто сделать из DirectoryDrawerWidget Inherited
      endDrawer: DirectFuncs(
        onClearAllTap: () => wm.onClearAllTap(),
        onDeleteWebsite: wm.onDeleteWebsite,
        onWebsiteTap: wm.onWebsiteTap,
        onLoginLongPress: wm.onLoginLongPress,
        onKeywordLongPress: wm.onKeywordLongPress,
        child: DirectoryDrawerWidget(
          listenableEntityState: wm.savedKeywordsListenable,
        ),
      ),
    );
  }
}
