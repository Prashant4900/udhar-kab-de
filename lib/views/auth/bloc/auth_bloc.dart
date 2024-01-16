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
    on<PhoneAuthInitiateEvent>(_phoneAuthInitiate);
    on<ValidateOTPEvent>(_validateOTP);
    on<UserStatusEvent>(_userState);
  }

  final authRepository = getIt<AuthRepository>();

  FutureOr<void> _signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(accountStatus: AccountStatus.loading));
    try {
      final user = await authRepository.signInWithGoogle();
      emit(
        state.copyWith(
          accountStatus: AccountStatus.accountVerified,
          user: user,
        ),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          accountStatus: AccountStatus.failure,
          message: 'Google Sign In Failed: $message',
        ),
      );
    }
  }

  FutureOr<void> _signOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(accountStatus: AccountStatus.loading));

    try {
      await authRepository.signOut();
      emit(
        state.copyWith(accountStatus: AccountStatus.accountLoggedOut),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          accountStatus: AccountStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _phoneAuthInitiate(
    PhoneAuthInitiateEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        accountStatus: AccountStatus.loading,
      ),
    );

    try {
      final userId =
          await authRepository.initiatePhoneAuth('+91${event.number}');
      if (userId == '') {
        emit(
          state.copyWith(
            accountStatus: AccountStatus.failure,
            message: 'Something Went Wrong! Try after some time',
          ),
        );
      } else {
        emit(
          state.copyWith(
            accountStatus: AccountStatus.accountCreated,
            userId: userId,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          accountStatus: AccountStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _validateOTP(
    ValidateOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(accountStatus: AccountStatus.loading));
    try {
      final userId = await authRepository.validateOTP(state.userId!, event.otp);
      if (userId == state.userId) {
        /// Here userId is of validateOTP and state.userId
        /// is of Phone number sending
        emit(
          state.copyWith(
            accountStatus: AccountStatus.accountVerified,
            userId: userId,
          ),
        );
      } else {
        emit(
          state.copyWith(
            accountStatus: AccountStatus.failure,
            message: 'Something went wrong',
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          accountStatus: AccountStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _userState(
    UserStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    try {
      final user = await authRepository.getCurrentSessionUser();
      emit(state.copyWith(userStatus: UserStatus.loggedIn, user: user));
    } catch (e) {
      emit(state.copyWith(userStatus: UserStatus.loggedOut));
    }
  }
}

//ui -> event ->  bloc -> state -> UI
