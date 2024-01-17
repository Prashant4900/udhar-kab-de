part of 'auth_bloc.dart';

enum AccountStatus {
  initial,
  loading,
  accountCreated,
  accountVerified,
  accountLoggedOut,
  failure
}

enum UserStatus { loading, loggedIn, loggedOut }

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.message,
    this.userId,
    this.isOTPResend = false,
    this.accountStatus,
    this.userStatus,
  });

  factory AuthState.initial() => const AuthState(
        accountStatus: AccountStatus.initial,
      );

  final AccountStatus? accountStatus;
  final UserStatus? userStatus;
  final User? user;
  final String? message;
  final String? userId;
  final bool isOTPResend;

  AuthState copyWith({
    AccountStatus? accountStatus,
    User? user,
    String? message,
    String? userId,
    bool isOTPResend = false,
    UserStatus? userStatus,
  }) {
    return AuthState(
      accountStatus: accountStatus ?? this.accountStatus,
      user: user ?? this.user,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      isOTPResend: isOTPResend,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  @override
  List<Object?> get props => [
        accountStatus,
        user,
        message,
        userId,
        isOTPResend,
        userStatus,
      ];
}
