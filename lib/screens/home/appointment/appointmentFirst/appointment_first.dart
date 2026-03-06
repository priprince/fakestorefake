import 'package:fakestorefake/constants/logs.dart';
import 'package:fakestorefake/screens/home/appointment/appointmentFirst/cubit/appointment_first_cubit.dart'
    show AppointmentFirstCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:go_router/go_router.dart';

class AppointmentFirstScreen extends StatelessWidget {
  const AppointmentFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        logger.e("did pop is $didPop");
        logger.t("result is $result");
        logger.f(GoRouter.of(context).state.fullPath);
        if (!didPop) {
          logger.d("inside if $didPop");
          if (context.canPop()) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        body: Column(children: [Text("This is Appointment First Screen")]),
      ),
    );
  }
}

class AppointmentFirstPage extends StatelessWidget {
  const AppointmentFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentFirstCubit(),
      child: const AppointmentFirstScreen(),
    );
  }
}
