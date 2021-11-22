// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TbdmUserModelAdapter extends TypeAdapter<TbdmUserModel> {
  @override
  final int typeId = 0;

  @override
  TbdmUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TbdmUserModel(
      fields[0] as String,
      fields[1] as String,
      fields[4] as String,
      incudeAdult: fields[2] as bool?,
      sessionID: fields[3] as String?,
      avatar: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TbdmUserModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.incudeAdult)
      ..writeByte(3)
      ..write(obj.sessionID)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TbdmUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
