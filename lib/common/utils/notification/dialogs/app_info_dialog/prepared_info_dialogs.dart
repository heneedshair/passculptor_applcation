import 'package:code_generator_app/common/utils/notification/dialogs/app_info_dialog/app_info_dialog.dart';
import 'package:code_generator_app/common/utils/notification/dialogs/app_info_dialog/widgets/info_section.dart';
import 'package:flutter/material.dart';

class PreparedInfoDialogs {
  static const howItWorks = AppInfoDialog(
    title: 'Как это работает?',
    description: 'PasSculptor создаёт надёжный пароль из введённых данных, но не сохраняет сам пароль в приложении.',
    icon: Icons.help_outline_rounded,
    closeLabel: 'Понятно',
    childrens: [
      AppInfoSection(
        subtitle: 'Логин',
        icon: Icons.person_rounded,
        text:
            'Введите логин от аккаунта. Это может быть почта, никнейм или имя пользователя.\n\nПоле можно оставить пустым, если вы точно не планируете добавлять несколько аккаунтов к одному сайту.',
      ),
      AppInfoSection(
        subtitle: 'Сайт/приложение',
        icon: Icons.web_asset_rounded,
        text:
            'Введите название сайта или приложения, для которого нужен пароль.\n\nНапример: gmail, google, steam или gosuslugi. Для каждого сайта будет создаваться свой уникальный пароль.',
      ),
      AppInfoSection(
        subtitle: 'Ключевое слово',
        icon: Icons.vpn_key_rounded,
        text:
            'Введите секретное слово, которое знаете только вы. Оно используется как главный ключ для создания пароля и не хранится в открытом виде.',
      ),
      AppInfoSection(
        subtitle: 'Создание пароля',
        icon: Icons.lock_rounded,
        text:
            'Пароль создаётся из трёх данных: логин, сайт и ключевое слово.\n\nЕсли ввести те же данные снова, приложение создаст тот же самый пароль. Если изменить хотя бы один символ, пароль получится другим.',
      ),
      AppInfoSection(
        subtitle: 'Сохранение',
        icon: Icons.bookmark_rounded,
        text:
            'Если включено сохранение, приложение запомнит сайт и логин. Сам пароль и ключевое слово не сохраняются. В следующий раз можно выбрать сайт из списка и снова создать пароль.',
      ),
    ],
  );

  static const aboutDirectory = AppInfoDialog(
    title: 'Список сайтов',
    description:
        'Здесь хранятся сохранённые связки ключевых слов, логинов и сайтов для быстрого повторного создания паролей.',
    icon: Icons.info_outline_rounded,
    closeLabel: 'Понятно',
    childrens: [
      AppInfoSection(
        subtitle: 'Ключевые слова',
        icon: Icons.vpn_key_rounded,
        text:
            'Логины группируются по ключевым словам.\n\nСамо ключевое слово не хранится полностью, только его первая буква Остальные символы заменяются на "*".',
      ),
      AppInfoSection(
        subtitle: 'Логины',
        icon: Icons.person_rounded,
        text:
            'Внутри каждого ключевого слова сайты разделяются по логинам. Если логин не был указан, сайт попадёт в группу "Без логина".',
      ),
      AppInfoSection(
        subtitle: 'Сайты',
        icon: Icons.web_asset_rounded,
        text:
            'Нажмите на сайт из списка, чтобы быстро подставить его название и логин в форму создания пароля. После этого останется ввести ключевое слово.',
      ),
      AppInfoSection(
        subtitle: 'Быстрое создание',
        icon: Icons.flash_on_rounded,
        text:
            'Если ключевое слово уже введено и совпадает по первой букве и длине с выбранной группой, пароль может создаться сразу после выбора сайта.',
      ),
      AppInfoSection(
        subtitle: 'Поиск',
        icon: Icons.search_rounded,
        text: 'Нажмите на лупу, чтобы быстро найти нужный сайт, логин или ключевое слово в сохранённом списке.',
      ),
      AppInfoSection(
        subtitle: 'Удаление',
        icon: Icons.delete_outline_rounded,
        text:
            'Сайт можно удалить свайпом. Группу логина или ключевого слова можно удалить долгим нажатием на её название.',
      ),
    ],
  );
}
