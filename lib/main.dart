import 'package:code_generator_app/common/utils/navigation/app_router.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/repositories/disk_data_repository.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(KeywordAdapter());
  Hive.registerAdapter(LoginAdapter());

  // TODO перенсти в init репозитория
  final websitesBox = await Hive.openBox<Keyword>('websites');
  final preferences = await SharedPreferences.getInstance();

  final diskDataRepository = DiskDataRepository(
    websitesBox: websitesBox,
    preferences: preferences,
  );

  runApp(
    Provider<IDiskDataRepository>.value(
      value: diskDataRepository,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PasSculptor',
      theme: AppThemeData.dark,
      routerConfig: _appRouter.config(),
    );
  }
}
