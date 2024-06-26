import 'package:chat_assignment/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConversationModelAdapter extends TypeAdapter<ConversationModel> {
  @override
  final int typeId = 0;

  @override
  ConversationModel read(BinaryReader reader) => ConversationModel.fromMap(
        reader.readMap().cast(),
      );

  @override
  void write(BinaryWriter writer, ConversationModel obj) {
    writer.writeMap(obj.toMap());
  }
}
