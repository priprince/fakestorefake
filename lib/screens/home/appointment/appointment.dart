import 'package:fakestorefake/routes/route_names.dart' show Routes;
import 'package:fakestorefake/screens/home/appointment/cubit/appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:go_router/go_router.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (context.canPop()) {
          context.pop();
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("This is Appointment Screen"),
              SizedBox(height: 25),
              FilledButton(
                onPressed: () {
                  // context.go(Routes.appointmentFirst);
                  context.push(Routes.appointmentFirst);
                  // context.go('/appointments/appointmentFirst');
                },
                child: Text("Appointment First Page"),
              ),
              SizedBox(height: 100),
              FilledButton(
                onPressed: () {
                  context.go(Routes.appointmentSecond);
                  // context.push(Routes.appointmentSecond);
                  // context.go('/appointments/appointmentSecond');
                },
                child: Text("Appointment Second Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit(),
      child: const AppointmentScreen(),
    );
  }
}
