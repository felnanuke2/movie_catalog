import 'package:hive/hive.dart';

part 'base_user.g.dart';

@HiveType(typeId: 0)
class BaseUser {
  @HiveField(0)
  String? userName;

  @HiveField(1)
  String? name;

  @HiveField(2)
  bool? incudeAdult;

  @HiveField(3)
  String? sessionID;

  BaseUser({
    this.userName,
    this.name,
    this.incudeAdult,
    this.sessionID,
  });
}
