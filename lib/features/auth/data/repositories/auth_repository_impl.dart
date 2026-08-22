import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  static const _sessionKey = 'CACHED_USER_SESSION';

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<UserEntity> verifyPin({
    required String restaurantId,
    required String pin,
  }) async {
    final userModel = await remoteDataSource.verifyPin(restaurantId, pin);
    await saveSession(userModel);
    return userModel;
  }

  @override
  Future<void> saveSession(UserEntity user) async {
    final model = UserModel(
      id: user.id,
      fullName: user.fullName,
      role: user.role,
      roleName: user.roleName,
      restaurantId: user.restaurantId,
    );
    await sharedPreferences.setString(_sessionKey, jsonEncode(model.toJson()));
  }

  @override
  Future<UserEntity?> getSavedSession() async {
    final jsonString = sharedPreferences.getString(_sessionKey);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(_sessionKey);
  }
}