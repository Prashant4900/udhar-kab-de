part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status,
    this.user,
    this.message,
  });

  final AuthStatus? status;
  final User? user;
  final String? message;

  static AuthState initial() => const AuthState(
        status: AuthStatus.initial,
      );

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status!,
        user!,
        message!,
      ];
}
