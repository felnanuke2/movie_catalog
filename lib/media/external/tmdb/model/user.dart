import 'package:hive/hive.dart';
import 'package:movie_catalog/auth/domain/entities/user.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class TbdmUserModel extends UserEntity {
  @HiveField(0)
  String userName;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool? incudeAdult;

  @HiveField(3)
  String? sessionID;

  @HiveField(4)
  String id;

  @HiveField(5)
  String? avatar;

  TbdmUserModel(
    this.userName,
    this.name,
    this.id, {
    this.incudeAdult,
    this.sessionID,
    this.avatar,
  }) : super(id: id, name: name);
}
