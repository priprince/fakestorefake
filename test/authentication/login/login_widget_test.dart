import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fakestorefake/constants/export_page.dart';
import 'package:fakestorefake/screens/authentication/login/bloc/login_bloc.dart';
import 'package:fakestorefake/screens/authentication/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart' show InheritedGoRouter, GoRouter;
import 'package:mocktail/mocktail.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'
    show ModalProgressHUD;

import '../signUp/sign_up_widget_test.dart';

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
    await test.tap(find.text(MyString.login));
    await test.pump();
    // verify(() => bloc.add(any(that: isA<LoginButtonEvent>()))).called(1);
    verify(() => bloc.add(LoginButtonEvent("email", "12"))).called(1);
  });

  testWidgets("navigate to home", (test) async {
    final MockLoginBloc bloc = MockLoginBloc();
    final MockRouter router = MockRouter();
    when(() => bloc.state).thenReturn(LoginInitialState());
    final controller = StreamController<LoginState>();
    whenListen(bloc, controller.stream, initialState: LoginInitialState());
    await test.pumpWidget(createWidgetUnderTest(bloc, router: router));
    controller.add(LoginSuccessState());
    await test.pump();
    verify(() => router.goNamed(Routes.home)).called(1);
    await controller.close();
  });
}

Widget createWidgetUnderTest(LoginBloc bloc, {GoRouter? router}) {
  return MaterialApp(
    home: InheritedGoRouter(
      goRouter: router ?? GoRouter(routes: []),
      child: BlocProvider<LoginBloc>.value(value: bloc, child: LoginScreen()),
    ),
  );
}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockLoginRouter extends Mock implements GoRouter {}
