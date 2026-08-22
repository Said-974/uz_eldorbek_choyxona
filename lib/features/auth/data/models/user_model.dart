import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.role,
    required super.roleName,
    required super.restaurantId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      role: UserEntity.parseRole(json['role_code'] as String? ?? ''),
      roleName: json['role_name'] as String? ?? '',
      restaurantId: json['restaurant_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'role_code': role.name.toUpperCase(),
      'role_name': roleName,
      'restaurant_id': restaurantId,
    };
  }
}