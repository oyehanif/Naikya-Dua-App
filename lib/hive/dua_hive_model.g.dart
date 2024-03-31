// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DuaHiveModelAdapter extends TypeAdapter<DuaHiveModel> {
  @override
  final int typeId = 0;

  @override
  DuaHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DuaHiveModel(
      id: fields[0] as int?,
      duaName: fields[1] as String,
      dua: fields[2] as String,
      tarjum: fields[3] as String,
      isFav: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DuaHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.duaName)
      ..writeByte(2)
      ..write(obj.dua)
      ..writeByte(3)
      ..write(obj.tarjum)
      ..writeByte(4)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DuaHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
