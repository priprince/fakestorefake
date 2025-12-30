import 'package:fakestorefake/screens/authentication/login/login.dart';
import 'package:fakestorefake/screens/authentication/signUp/sign_up.dart';
import 'package:fakestorefake/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

final router = GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    ShellRoute(
      builder: (context, state, child) {
        return HomePage();
      },
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => HomePage(),
          routes: [
            GoRoute(
              path: Routes.first,
              builder: (context, state) => Center(child: Text("first")),
            ),
            GoRoute(
              path: Routes.second,
              builder: (context, state) => Center(child: Text("second")),
            ),
          ],
        ),
        GoRoute(
          path: '/appointments',
          // builder: (context, state) => AppointmentsPage(),
        ),
        GoRoute(
          path: '/profile',
          // builder: (context, state) => ProfilePage(),
        ),
      ],
    ),
  ],
);
