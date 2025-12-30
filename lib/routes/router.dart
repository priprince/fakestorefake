import 'package:fakestorefake/screens/authentication/login/login.dart';
import 'package:fakestorefake/screens/authentication/signUp/sign_up.dart';
import 'package:fakestorefake/screens/home/home.dart';
import 'package:fakestorefake/screens/home/list/list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

final router = GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.list,
              name: Routes.list,
              builder: (context, state) => ListPage(),
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
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.appointments,
              builder: (context, state) => Center(child: Text("Appointmens")),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              builder: (context, state) => Center(child: Text("profile")),
            ),
          ],
        ),
      ],
    ),
  ],
);
