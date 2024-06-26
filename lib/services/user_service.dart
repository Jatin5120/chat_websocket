import 'package:chat_assignment/data/data.dart';
import 'package:chat_assignment/models/models.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService {
  const UserService(this._dbClient);

  final DbClient _dbClient;

  UserModel? getUser(String id) {
    try {
      return _dbClient.getUser(id);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final users = _dbClient.getAllUsers();
      return users.cast().firstWhere(
            (user) => user.email == email,
            orElse: () => null,
          );
    } catch (e) {
      return null;
    }
  }

  Future<void> createUser(UserModel user) async {
    await _dbClient.addUser(user.id, user);
  }

  Future<void> updateUser(UserModel user) async {
    await _dbClient.updateUser(user.id, user);
  }
}
