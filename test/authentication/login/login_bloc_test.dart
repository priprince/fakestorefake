import 'package:bloc_test/bloc_test.dart';
import 'package:fakestorefake/screens/authentication/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('login bloc test', () {
    test("initial state is LoginInitial State", () {
      final bloc = LoginBloc();
      expect(bloc.state, isA<LoginInitialState>());
    });

    blocTest<LoginBloc, LoginState>(
      'emits first errors state second initial State',
      build: () => LoginBloc(),
      act: (bloc) => bloc.add(const LoginButtonEvent('', '12')),
      expect: () => [
        const LoginErrorState('Email required'),
        isA<LoginInitialState>(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits first erros state if password is invalid then initial State',
      build: () => LoginBloc(),
      act: (bloc) => bloc.add(const LoginButtonEvent('test@mail.com', '1')),
      expect: () => [
        const LoginErrorState('Password must be 2 chars'),
        isA<LoginInitialState>(),
      ],
    );
  });

  blocTest<LoginBloc, LoginState>(
    'emits mock loading state then succcess state',
    build: () => LoginBloc(),
    act: (bloc) => bloc.add(const LoginButtonEvent('test@mail.com', '12')),
    expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()],
  );
}

// 53 =20  26 = 12
//mixer meena,mama,amma,pravin amma,owner,

final cake = {
  "amma": {"number": 3, "price": 20},
  "meena": {"number": 4, "price": 20},
  "mama": {"number": 5, "price": 20},
  "madhu": {"number": 5, "price": 20},
  "gnaneshma": {"number": 6, "price": 20},
  "jothi": {"number": 4, "price": 12},
  "jothi daughter priya": {"number": 4, "price": 20},
  "pavithra house": {"number": 5, "price": 20},
  "pravin amma": {"number": 4, "price": 20},
  "office": {"number": 6, "price": 20},
  "abid ali family": {"number": 4, "price": 20},
  "palasaruku kadai": {"number": 4, "price": 12},
  "waffles": {"number": 4, "price": 12},
  "banana shop": {"number": 5, "price": 12},
  "slipper anna": {"number": 4, "price": 12},
  "pakkathu veedu": {"number": 4, "price": 20},
  "owner": {"number": 6, "price": 20},
  "house maid": {"number": 5, "price": 12},
};
//cake 
// meena = 4
// mama = 5 
//madhu = 5 
//gnaneshma = 6


