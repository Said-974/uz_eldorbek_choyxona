import 'package:equatable/equatable.dart';

enum UserRole { admin, cashier, waiter, kitchen, unknown }

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final UserRole role;
  final String roleName;
  final String restaurantId;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.role,
    required this.roleName,
    required this.restaurantId,
  });

  static UserRole parseRole(String roleCode) {
    switch (roleCode.toUpperCase()) {
      case 'ADMIN':
        return UserRole.admin;
      case 'CASHIER':
        return UserRole.cashier;
      case 'WAITER':
        return UserRole.waiter;
      case 'KITCHEN':
        return UserRole.kitchen;
      default:
        return UserRole.unknown;
    }
  }

  @override
  List<Object?> get props => [id, fullName, role, restaurantId];
}