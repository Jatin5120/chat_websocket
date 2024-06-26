import 'package:chat_assignment/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) => UserModel.fromMap(reader.readMap().cast());

  @override
  void write(BinaryWriter writer, UserModel obj) {
    // Convert UserModel instance to bytes
    writer.writeMap(obj.toMap());
  }
}
