import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  User({required this.email, required this.password});
}
