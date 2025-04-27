import 'package:code_generator_app/data/models/login/login.dart';
import 'package:hive/hive.dart';
part 'keyword.g.dart';

@HiveType(typeId: 0)
class Keyword {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Login> logins;

  Keyword(this.name, this.logins);

  @override
  String toString() => '$name: $logins';

  /// Ищем логин в ключевом слове.
  Login getLogin(String enteredLogin) {
    return logins.firstWhere(
      (l) => l.username == enteredLogin,
      orElse: () => Login(enteredLogin, []),
    );
  }

  /// Добавляем логин, если он уникален.
  void addNewLogin(Login newLogin) {
    if (!logins.any((l) => l.username == newLogin.username)) {
      logins.add(newLogin);
    }
  }
}
