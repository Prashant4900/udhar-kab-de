import 'dart:async';

import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/repositories/auth_repository.dart';
import 'package:mobile/setup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<SignOutEvent>(_signOut);
  }

  final authRepository = getIt<AuthRepository>();

  FutureOr<void> _signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await authRepository.signInWithGoogle();
      emit(state.copyWith(status: AuthStatus.success, user: user));
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: 'Google Sign In Failed: $message',
        ),
      );
    }
  }

  FutureOr<void> _signOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await authRepository.signOut();
      emit(
        state.copyWith(
          status: AuthStatus.success,
        ),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: message,
        ),
      );
    }
  }
}
