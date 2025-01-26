// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectsEntityAdapter extends TypeAdapter<SubjectsEntity> {
  @override
  final int typeId = 1;

  @override
  SubjectsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectsEntity(
      id: fields[0] as String?,
      subjectName: fields[1] as String,
      versionID: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectsEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.versionID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
