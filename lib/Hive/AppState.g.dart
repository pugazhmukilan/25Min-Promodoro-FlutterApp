// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppState.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppStateAdapter extends TypeAdapter<AppState> {
  @override
  final int typeId = 2;

  @override
  AppState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppState(
      totalEfficiency: fields[0] as double,
      totalSessions: fields[1] as int,
      isSessionActive: fields[2] as bool,
      activeSessionId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppState obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalEfficiency)
      ..writeByte(1)
      ..write(obj.totalSessions)
      ..writeByte(2)
      ..write(obj.isSessionActive)
      ..writeByte(3)
      ..write(obj.activeSessionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
