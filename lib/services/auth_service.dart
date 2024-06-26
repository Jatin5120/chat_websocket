import 'dart:async';

import 'package:chat_assignment/data/data.dart';
import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/services/services.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class AuthService {
  AuthService(this._dbClient, this._userService);

  final UserService _userService;
  final DbClient _dbClient;
  final Uuid _uuid = const Uuid();

  bool isLoggedIn() => _dbClient.getIsLoggedIn();

  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final user = await _userService.getUserByEmail(email);

    if (user == null) {
      throw AppException('User not found');
    }
    if (user.email == email && user.password == password) {
      await Future.wait([
        _dbClient.setUserId(user.id),
        _dbClient.setIsLoggedIn(true),
      ]);
      return user;
    }

    throw AppException('Invalid credentials');
  }

  Future<UserModel?> signupUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final existingUser = await _userService.getUserByEmail(email);
    if (existingUser != null) {
      throw AppException('User with this email already exists');
    }

    final userId = _uuid.v4();
    final newUser = UserModel(
      id: userId,
      email: email,
      name: name,
      password: password,
    );
    await Future.wait([
      _userService.createUser(newUser),
      _dbClient.setUserId(newUser.id),
      _dbClient.setIsLoggedIn(true),
    ]);
    return newUser;
  }

  Future<void> signOut() => Future.wait([
        _dbClient.setIsLoggedIn(false),
      ]);
}
