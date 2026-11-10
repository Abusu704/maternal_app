// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kick_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KickLogAdapter extends TypeAdapter<KickLog> {
  @override
  final int typeId = 2;

  @override
  KickLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KickLog(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      count: fields[2] as int,
      durationInMinutes: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, KickLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.durationInMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KickLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
