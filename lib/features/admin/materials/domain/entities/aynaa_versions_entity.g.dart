// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aynaa_versions_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AynaaVersionsEntityAdapter extends TypeAdapter<AynaaVersionsEntity> {
  @override
  final int typeId = 0;

  @override
  AynaaVersionsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AynaaVersionsEntity(
      id: fields[0] as String,
      versionName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AynaaVersionsEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.versionName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AynaaVersionsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
