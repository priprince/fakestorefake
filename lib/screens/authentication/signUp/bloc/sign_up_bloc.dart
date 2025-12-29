import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonEvent>(signUpButtonMethod);
  }

  FutureOr<void> signUpButtonMethod(
    SignUpButtonEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final name = event.name;
    final email = event.email;
    final password = event.password;
    if (name.isEmpty) {
      emit(const SignUpErrorState('Name required'));
      emit(SignUpInitial());
      return;
    }
    if (email.isEmpty) {
      emit(const SignUpErrorState('Email required'));
      emit(SignUpInitial());
      return;
    }
    if (password.length < 2) {
      emit(const SignUpErrorState('Password must be 2 chars'));
      emit(SignUpInitial());
      return;
    }
    emit(SignUpLoadingState());
    await Future.delayed(const Duration(milliseconds: 800));
    emit(SignUpSuccessState());
  }
}
