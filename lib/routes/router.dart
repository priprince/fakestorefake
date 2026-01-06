import 'package:fakestorefake/screens/authentication/login/login.dart';
import 'package:fakestorefake/screens/authentication/signUp/sign_up.dart';
import 'package:fakestorefake/screens/home/home.dart';
import 'package:fakestorefake/screens/home/product/product.dart';
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
              path: Routes.products,
              name: Routes.products,
              builder: (context, state) => ProductPage(),
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
