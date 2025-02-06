// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_mark_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookMarksModelAdapter extends TypeAdapter<BookMarksModel> {
  @override
  final int typeId = 0;

  @override
  BookMarksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookMarksModel(
      fields[0] as String,
      fields[1] as bool,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BookMarksModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.isBookRead)
      ..writeByte(2)
      ..write(obj.isBookMark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookMarksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
