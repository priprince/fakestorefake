import 'package:bloc_test/bloc_test.dart';
import 'package:fakestorefake/screens/authentication/login/bloc/login_bloc.dart';
import 'package:fakestorefake/screens/authentication/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'
    show ModalProgressHUD;

void main() {
  setUpAll(() {
    registerFallbackValue(const LoginButtonEvent('', ''));

    registerFallbackValue(LoginInitialState());
  });
  testWidgets("check email & password fields & login button", (test) async {
    final MockLoginBloc bloc = MockLoginBloc();
    when(() => bloc.state).thenReturn(LoginInitialState());
    await test.pumpWidget(createWidgetUnderTest(bloc));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text("Login"), findsOneWidget);
  });

  testWidgets("show loading when logingLoadingState is emitted", (test) async {
    final MockLoginBloc bloc = MockLoginBloc();
    when(() => bloc.state).thenReturn(LoginLoadingState());
    await test.pumpWidget(createWidgetUnderTest(bloc));
    expect(find.byType(ModalProgressHUD), findsOneWidget);
  });

  testWidgets("login Button Event", (test) async {
    final MockLoginBloc bloc = MockLoginBloc();
    when(() => bloc.state).thenReturn(LoginInitialState());
    await test.pumpWidget(createWidgetUnderTest(bloc));
    await test.enterText(find.byType(TextFormField).at(0), 'test@gmail.com');
    await test.enterText(find.byType(TextFormField).at(1), '12');
    await test.tap(find.text("Login"));
    await test.pump();
    // verify(() => bloc.add(any(that: isA<LoginButtonEvent>()))).called(1);
    verify(() => bloc.add(LoginButtonEvent("email", "12"))).called(1);
  });
}

Widget createWidgetUnderTest(LoginBloc bloc) {
  return MaterialApp(
    home: BlocProvider<LoginBloc>.value(value: bloc, child: LoginScreen()),
  );
}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}
