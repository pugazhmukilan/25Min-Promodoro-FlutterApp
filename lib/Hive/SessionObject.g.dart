// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SessionObject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PomodoroSessionAdapter extends TypeAdapter<PomodoroSession> {
  @override
  final int typeId = 0;

  @override
  PomodoroSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PomodoroSession(
      sessionId: fields[0] as String,
      taskIds: (fields[1] as List).cast<String>(),
      totalSprints: fields[2] as int,
      completedSprints: fields[3] as int,
      startTime: fields[4] as DateTime,
      sessionDuration: fields[5] as Duration,
      isCompleted: fields[6] as bool,
      efficiency: fields[7] as int,
      totalTaskCount: fields[8] as int,
      completedTaskCount: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PomodoroSession obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.taskIds)
      ..writeByte(2)
      ..write(obj.totalSprints)
      ..writeByte(3)
      ..write(obj.completedSprints)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.sessionDuration)
      ..writeByte(6)
      ..write(obj.isCompleted)
      ..writeByte(7)
      ..write(obj.efficiency)
      ..writeByte(8)
      ..write(obj.totalTaskCount)
      ..writeByte(9)
      ..write(obj.completedTaskCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomodoroSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
