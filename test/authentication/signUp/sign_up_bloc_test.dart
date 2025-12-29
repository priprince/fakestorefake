import 'package:bloc_test/bloc_test.dart';
import 'package:fakestorefake/screens/authentication/signUp/bloc/sign_up_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("sign up bloc test", () {
    test("initial test login initial", () {
      final bloc = SignUpBloc();
      expect(bloc.state, isA<SignUpInitial>());
    });

    blocTest<SignUpBloc, SignUpState>(
      "emits email error state",
      build: () => SignUpBloc(),
      act: (bloc) => bloc.add(const SignUpButtonEvent("", "name", "password")),
      expect: () => [
        const SignUpErrorState('Email required'),
        isA<SignUpInitial>(),
      ],
    );

    blocTest(
      "emits name error state",
      build: () => SignUpBloc(),
      act: (bloc) => bloc.add(const SignUpButtonEvent("email", "", "password")),
      expect: () => [
        const SignUpErrorState('name required'),
        isA<SignUpInitial>(),
      ],
    );
    blocTest(
      "emits password error state",
      build: () => SignUpBloc(),
      act: (bloc) => bloc.add(const SignUpButtonEvent("email", "name", "")),
      expect: () => [
        const SignUpErrorState('password required'),
        isA<SignUpInitial>(),
      ],
    );

    blocTest(
      "emits loading state then success state",
      build: () => SignUpBloc(),
      act: (bloc) => bloc.add(const SignUpButtonEvent("email", "name", "12")),
      wait: const Duration(milliseconds: 900),
      expect: () => [isA<SignUpLoadingState>(), isA<SignUpSuccessState>()],
    );
  });
}
