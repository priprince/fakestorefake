import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fakestorefake/constants/export_page.dart';
import 'package:fakestorefake/screens/authentication/signUp/bloc/sign_up_bloc.dart';
import 'package:fakestorefake/screens/authentication/signUp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart' show GoRouter, InheritedGoRouter;
import 'package:mocktail/mocktail.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(SignUpButtonEvent("email", "name", "password"));
    registerFallbackValue(SignUpInitial());
  });

  testWidgets("email,name,password fields and sign up button", (test) async {
    final MockSignUpBloc bloc = MockSignUpBloc();
    when(() => bloc.state).thenReturn(SignUpInitial());
    await test.pumpWidget(createWidget(bloc));
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text(MyString.signUp), findsOneWidget);
  });

  testWidgets('show loading', (test) async {
    final MockSignUpBloc bloc = MockSignUpBloc();
    when(() => bloc.state).thenReturn(SignUpLoadingState());
    await test.pumpWidget(createWidget(bloc));
    expect(find.byType(ModalProgressHUD), findsOneWidget);
  });

  testWidgets("Sign up button event", (test) async {
    final MockSignUpBloc bloc = MockSignUpBloc();
    when(() => bloc.state).thenReturn(SignUpInitial());
    await test.pumpWidget(createWidget(bloc));
    await test.enterText(find.byType(TextFormField).at(0), "test@gmail.com");
    await test.enterText(find.byType(TextFormField).at(1), "pravin");
    await test.enterText(find.byType(TextFormField).at(2), "12");
    await test.tap(find.text(MyString.signUp));
    await test.pump();
    verify(
      () => bloc.add(SignUpButtonEvent("test@gmail.com", "pravin", "12")),
    ).called(1);
  });

  testWidgets("navigates to home when sign up suceeds", (test) async {
    final MockSignUpBloc bloc = MockSignUpBloc();
    final MockRouter router = MockRouter();
    final controller = StreamController<SignUpState>();
    when(() => bloc.state).thenReturn(SignUpInitial());
    whenListen(bloc, controller.stream, initialState: SignUpInitial());
    await test.pumpWidget(createWidget(bloc, router: router));
    controller.add(SignUpSuccessState());
    await test.pump();
    verify(() => router.go(Routes.home)).called(1);
    await controller.close();
  });
}

Widget createWidget(SignUpBloc bloc, {GoRouter? router}) {
  return MaterialApp(
    home: InheritedGoRouter(
      goRouter: router ?? GoRouter(routes: []),
      child: BlocProvider.value(value: bloc, child: SignUpScreen()),
    ),
  );
}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockRouter extends Mock implements GoRouter {}
