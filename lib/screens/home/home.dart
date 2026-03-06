import 'package:fakestorefake/constants/logs.dart' show logger;
import 'package:fakestorefake/screens/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.navigationShell, {super.key});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    // final uri = GoRouterState.of(context).uri;
    // final path = uri.path;
    // int index = 0;
    // if (path.startsWith(Routes.appointments)) index = 1;
    // if (path.startsWith(Routes.profile)) index = 2;
    // logger.i(path);
    // logger.i(index);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        logger.i("inside the home page $didPop -----$result");
        if (!didPop) {
          logger.i("inside if in home not did pop ---$didPop");
        } else {
          logger.i("inside if in home  did pop ---$didPop");
        }
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (i) {
            navigationShell.goBranch(
              i,
              initialLocation: i == navigationShell.currentIndex,
            );
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_blocking_outlined),
              label: 'Appointment',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage(this.navigationShell, {super.key});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: HomeScreen(navigationShell),
    );
  }
}
