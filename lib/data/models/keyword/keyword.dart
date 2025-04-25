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
}