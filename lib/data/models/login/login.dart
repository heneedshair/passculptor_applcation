import 'package:hive/hive.dart';

part 'login.g.dart';

@HiveType(typeId: 1)
class Login {
  @HiveField(0)
  String username;

  @HiveField(1)
  List<String> websites;

  Login(this.username, this.websites);

  @override
  String toString() => '$username: $websites';
}