import 'package:bloc_test/bloc_test.dart';
import 'package:fakestorefake/repository/data_state.dart';
import 'package:fakestorefake/repository/loginRepository/login_repo.dart'
    show LoginRepo;
import 'package:fakestorefake/screens/authentication/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' show Mock, any, when;

void main() {
  late MockLoginRepo mockLoginRepo;

  setUp(() {
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
    // build: () => LoginBloc(mockLoginRepo),
    build: () {
      when(() => mockLoginRepo.login(any<String>(), any<String>())).thenAnswer(
        (add) async => Result.success(
          "pass data",
          message: "Login test ${add.memberName}",
        ),
      );
      // when(() => mockLoginRepo.login('john@mail.com', 'changeme')).thenAnswer(
      //   (_) async => Result.success("pass data", message: "sfsdfsdff"),
      // );

      return LoginBloc(mockLoginRepo);
    },
    act: (bloc) =>
        bloc.add(const LoginButtonEvent('john@mail.com', 'changeme')),

    expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()],
  );
}

class MockLoginRepo extends Mock implements LoginRepo {}
