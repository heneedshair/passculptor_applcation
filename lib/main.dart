import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/ui/main/main_screen.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  // HIVE
  await Hive.initFlutter();
  Hive.registerAdapter(KeywordAdapter());
  Hive.registerAdapter(LoginAdapter());
  await Hive.openBox<Keyword>('websites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PasSculptor',
      theme: AppTheme.themeData,
      home: MainScreen(),
    );
  }
}
