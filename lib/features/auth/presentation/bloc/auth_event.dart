import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class CheckAuthSessionEvent extends AuthEvent {}

class SubmitPinEvent extends AuthEvent {
  final String restaurantId;
  final String pin;

  const SubmitPinEvent({required this.restaurantId, required this.pin});

  @override
  List<Object?> get props => [restaurantId, pin];
}

class LogoutEvent extends AuthEvent {}