import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<CheckAuthSessionEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final session = await authRepository.getSavedSession();
        if (session != null) {
          emit(Authenticated(session));
        } else {
          emit(Unauthenticated());
        }
      } catch (_) {
        emit(Unauthenticated());
      }
    });

    on<SubmitPinEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.verifyPin(
          restaurantId: event.restaurantId,
          pin: event.pin,
        );
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError(e.toString().replaceAll('Exception: ', '')));
        emit(Unauthenticated());
      }
    });

    on<LogoutEvent>((event, emit) async {
      await authRepository.logout();
      emit(Unauthenticated());
    });
  }
}