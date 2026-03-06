import 'package:fakestorefake/screens/authentication/login/login.dart';
import 'package:fakestorefake/screens/authentication/signUp/sign_up.dart';
import 'package:fakestorefake/screens/home/appointment/appointment.dart'
    show AppointmentPage;
import 'package:fakestorefake/screens/home/appointment/appointmentFirst/appointment_first.dart';
import 'package:fakestorefake/screens/home/appointment/appointmentSecond/appointment_second.dart'
    show AppointmentSecondPage;
import 'package:fakestorefake/screens/home/home.dart';
import 'package:fakestorefake/screens/home/product/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final productShellNavigatorKey = GlobalKey<NavigatorState>();
final appointmentShellNavigatorKey = GlobalKey<NavigatorState>();
final profileShellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.products,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: productShellNavigatorKey,
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
          navigatorKey: appointmentShellNavigatorKey,
          routes: [
            GoRoute(
              path: Routes.appointments,
              builder: (context, state) => AppointmentPage(),
              routes: [
                GoRoute(
                  path: "appointmentFirst",
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: AppointmentFirstPage(),
                  ),
                ),
                GoRoute(
                  path: "appointmentSecond",
                  builder: (context, state) => AppointmentSecondPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: profileShellNavigatorKey,
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
