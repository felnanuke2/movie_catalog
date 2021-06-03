import 'package:hive/hive.dart';

part '../hive/base_user.g.dart';

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

  @HiveField(4)
  int? id;

  @HiveField(5)
  String? avatar;

  BaseUser({this.userName, this.name, this.incudeAdult, this.sessionID, this.avatar, this.id});
}
