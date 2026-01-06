import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fakestorefake/repository/loginRepository/login_repo.dart';
import 'package:fakestorefake/repository/loginRepository/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/export_page.dart' show logger;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginInterface _loginRepo;
  LoginBloc(this._loginRepo) : super(LoginInitialState()) {
    on<LoginButtonEvent>(loginButtonEventMethod);
    on<LoginErrorEvent>(loginErrorEventMethod);
    on<LoginSuccessEvent>(loginSuccessEventMethod);
    // on<LoginLoadingEvent>(loginLoadingEventMethod);
  }

  FutureOr<void> loginButtonEventMethod(
    LoginButtonEvent event,
    Emitter<LoginState> emit,
  ) async {
    final email = event.email;
    final password = event.password;
    if (email.isEmpty) {
      emit(const LoginErrorState('Email required'));
      emit(LoginInitialState());
      return;
    }
    if (password.length < 2) {
      emit(const LoginErrorState('Password must be 2 chars'));
      emit(LoginInitialState());
      return;
    }
    emit(LoginLoadingState());
    final response = await _loginRepo.login(email, password);
    logger.i(response);
    if (response.isSuccess) {
      logger.d(response.message);
      emit(LoginSuccessState());
      return;
    }
    emit(LoginErrorState(response.message ?? ""));
  }

  FutureOr<void> loginLoadingEventMethod(
    LoginLoadingEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginLoadingState());
  }

  FutureOr<void> loginErrorEventMethod(
    LoginErrorEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginErrorState(event.message));
    emit(LoginInitialState());
  }

  FutureOr<void> loginSuccessEventMethod(
    LoginSuccessEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginSuccessState());
  }
}
