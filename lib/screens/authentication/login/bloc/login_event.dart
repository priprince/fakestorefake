part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginButtonEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonEvent(this.email, this.password);
}

final class LoginLoadingEvent extends LoginEvent {}

final class LoginErrorEvent extends LoginEvent {
  final String message;

  const LoginErrorEvent(this.message);
}

final class LoginSuccessEvent extends LoginEvent {
  final String message;

  const LoginSuccessEvent(this.message);
}
