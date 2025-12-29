part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpButtonEvent extends SignUpEvent {
  final String email;
  final String name;
  final String password;

  const SignUpButtonEvent(this.email, this.name, this.password);
}

final class SignUpLoadingEvent extends SignUpEvent {}

final class SignUpErrorEvent extends SignUpEvent {
  final String errorMessage;

  const SignUpErrorEvent(this.errorMessage);
}

final class SignUpSuccessEvent extends SignUpEvent {
  final String successMessage;

  const SignUpSuccessEvent(this.successMessage);
}
