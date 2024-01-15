part of 'auth_bloc.dart';

enum AccountStatus {
  initial,
  loading,
  accountCreated,
  accountVerified,
  accountLogedOut,
  failure
}

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.message,
    this.userId,
    this.isOTPResended,
    this.accountStatus,
  });

  
  final AccountStatus? accountStatus;
  final User? user;
  final String? message;
  final String? userId;
  final bool? isOTPResended;

  static AuthState initial() => const AuthState(
        accountStatus: AccountStatus.initial,
        isOTPResended: false,
      );

  AuthState copyWith(
      {AccountStatus? accountStatus,
      User? user,
      String? message,
      String? userId,
      bool? isOTPResended}) {
    return AuthState(
        accountStatus: accountStatus ?? this.accountStatus,
        user: user ?? this.user,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        isOTPResended: isOTPResended ?? this.isOTPResended);
  }

  @override
  List<Object> get props =>
      [accountStatus!, user!, message!, userId!, isOTPResended!];
}
