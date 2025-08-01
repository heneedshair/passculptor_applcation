// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeywordAdapter extends TypeAdapter<Keyword> {
  @override
  final int typeId = 0;

  @override
  Keyword read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Keyword(
      fields[0] as String,
      (fields[1] as List).cast<Login>(),
    );
  }

  @override
  void write(BinaryWriter writer, Keyword obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.logins);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeywordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
