import 'package:bloc_test/bloc_test.dart';
import 'package:fakestorefake/repository/loginRepository/login_repo.dart'
    show LoginRepo;
import 'package:fakestorefake/screens/authentication/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' show Mock;

void main() {
  late MockLoginRepo mockLoginRepo;

  setUpAll(() {
    mockLoginRepo = MockLoginRepo();
  });
  group('login bloc test', () {
    test("initial state is LoginInitial State", () {
      final bloc = LoginBloc(mockLoginRepo);
      expect(bloc.state, isA<LoginInitialState>());
    });

    blocTest<LoginBloc, LoginState>(
      'emits first errors state second initial State',
      build: () => LoginBloc(mockLoginRepo),
      act: (bloc) => bloc.add(const LoginButtonEvent('', '12')),
      expect: () => [
        const LoginErrorState('Email required'),
        isA<LoginInitialState>(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits first erros state if password is invalid then initial State',
      build: () => LoginBloc(mockLoginRepo),
      act: (bloc) => bloc.add(const LoginButtonEvent('test@mail.com', '1')),
      expect: () => [
        const LoginErrorState('Password must be 2 chars'),
        isA<LoginInitialState>(),
      ],
    );
  });

  blocTest<LoginBloc, LoginState>(
    'emits mock loading state then succcess state',
    build: () => LoginBloc(mockLoginRepo),
    act: (bloc) => bloc.add(const LoginButtonEvent('test@mail.com', '12')),

    expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()],
  );
}

class MockLoginRepo extends Mock implements LoginRepo {}
