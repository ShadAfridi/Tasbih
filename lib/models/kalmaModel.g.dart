// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kalmaModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KalmaModelAdapter extends TypeAdapter<KalmaModel> {
  @override
  KalmaModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KalmaModel(
      kalma: fields[0] as String,
      tdr: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KalmaModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.kalma)
      ..writeByte(1)
      ..write(obj.tdr);
  }

  @override
  final typeId = 1;
}
