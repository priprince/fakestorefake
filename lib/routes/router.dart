import 'package:fakestorefake/screens/authentication/login/login.dart';
import 'package:fakestorefake/screens/authentication/signUp/sign_up.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

final router = GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    ShellRoute(
      builder: (context, state, child) {
        return child;
      },
      routes: [
        GoRoute(
          path: '/home',
          // builder: (context, state) => HomePage(),
          routes: [
            // tab bar routes go here
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
