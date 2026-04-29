import 'package:code_generator_app/common/utils/navigation/app_router.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/models/login/login.dart';
import 'package:code_generator_app/data/repositories/disk_data_repository.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(KeywordAdapter());
  Hive.registerAdapter(LoginAdapter());

  runApp(
    Provider<IDiskDataRepository>.value(
      value: await DiskDataRepository.create(),
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
