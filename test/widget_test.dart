import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:code_generator_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('builds app with disk repository provider', (tester) async {
    await tester.pumpWidget(
      Provider<IDiskDataRepository>.value(
        value: _FakeDiskDataRepository(),
        child: MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}

class _FakeDiskDataRepository implements IDiskDataRepository {
  @override
  Future<List<Keyword>> loadKeywords() async => const [];

  @override
  Future<void> addWebsite({
    required String login,
    required String website,
    required String keyword,
  }) async {}

  @override
  bool containsSameKeyword(String keyword) => false;

  @override
  Future<void> clearKeywords() async {}

  @override
  Future<void> deleteWebsite({
    required String website,
    required String login,
    required String keyword,
  }) async {}

  @override
  Future<void> deleteLogin({
    required String login,
    required String keyword,
  }) async {}

  @override
  Future<void> deleteKeyword(String keyword) async {}

  @override
  bool get isLoginObscured => false;

  @override
  Future<void> setLoginObscured(bool value) async {}

  @override
  bool get isKeyObscured => true;

  @override
  Future<void> setKeyObscured(bool value) async {}

  @override
  bool get isPasswordObscured => true;

  @override
  Future<void> setPasswordObscured(bool value) async {}

  @override
  bool get doSave => true;

  @override
  Future<void> setDoSave(bool value) async {}

  @override
  String? get encryptionAlgorithm => null;

  @override
  Future<void> setEncryptionAlgorithm(String value) async {}
}
