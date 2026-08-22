import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> verifyPin({
    required String restaurantId,
    required String pin,
  });
  Future<void> saveSession(UserEntity user);
  Future<UserEntity?> getSavedSession();
  Future<void> logout();
}