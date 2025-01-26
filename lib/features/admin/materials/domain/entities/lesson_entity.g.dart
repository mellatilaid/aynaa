// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonEntityAdapter extends TypeAdapter<LessonEntity> {
  @override
  final int typeId = 2;

  @override
  LessonEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonEntity(
      id: fields[0] as String?,
      name: fields[1] as String?,
      url: fields[2] as String?,
      description: fields[3] as String?,
      aynaaVersionId: fields[4] as String,
      subjectId: fields[5] as String,
      versionName: fields[6] as String,
      subjectName: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LessonEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.aynaaVersionId)
      ..writeByte(5)
      ..write(obj.subjectId)
      ..writeByte(6)
      ..write(obj.versionName)
      ..writeByte(7)
      ..write(obj.subjectName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
