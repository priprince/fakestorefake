part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpSuccessState extends SignUpState {
  const SignUpSuccessState();
}

final class SignUpErrorState extends SignUpState {
  final String errorMessage;

  const SignUpErrorState(this.errorMessage);
}
