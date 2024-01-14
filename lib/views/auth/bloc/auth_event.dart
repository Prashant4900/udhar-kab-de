part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignInWithGoogleEvent extends AuthEvent {}

final class PhoneAuthInitiateEvent extends AuthEvent {
  const PhoneAuthInitiateEvent({required this.number});

  final String number;

  @override
  List<Object> get props => [super.props, number];
}

final class ValidateOTPEvent extends AuthEvent {
  const ValidateOTPEvent({required this.otp});

  final String otp;

  @override
  List<Object> get props => [super.props, otp];
}

final class SignOutEvent extends AuthEvent {}

final class UserStatusEvent extends AuthEvent {}
