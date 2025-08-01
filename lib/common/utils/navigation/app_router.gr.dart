// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    Key? key,
    required EncryptionType initialEncryptionType,
    List<PageRouteInfo>? children,
  }) : super(
          SettingsRoute.name,
          args: SettingsRouteArgs(
            key: key,
            initialEncryptionType: initialEncryptionType,
          ),
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>();
      return SettingsScreen(
        key: args.key,
        initialEncryptionType: args.initialEncryptionType,
      );
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({
    this.key,
    required this.initialEncryptionType,
  });

  final Key? key;

  final EncryptionType initialEncryptionType;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, initialEncryptionType: $initialEncryptionType}';
  }
}
