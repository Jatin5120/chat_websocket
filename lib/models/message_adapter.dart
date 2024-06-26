import 'package:chat_assignment/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 1;

  @override
  MessageModel read(BinaryReader reader) => MessageModel.fromMap(reader.readMap().cast());

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer.writeMap(obj.toMap());
  }
}
