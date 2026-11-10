// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vitals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VitalsAdapter extends TypeAdapter<Vitals> {
  @override
  final int typeId = 1;

  @override
  Vitals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vitals(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      systolicBP: fields[2] as int,
      diastolicBP: fields[3] as int,
      weight: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Vitals obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.systolicBP)
      ..writeByte(3)
      ..write(obj.diastolicBP)
      ..writeByte(4)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VitalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
