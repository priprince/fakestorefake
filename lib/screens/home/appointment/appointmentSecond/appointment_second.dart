import 'package:fakestorefake/screens/home/appointment/appointmentSecond/cubit/appointment_second_cubit.dart'
    show AppointmentSecondCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

class AppointmentSecondScreen extends StatelessWidget {
  const AppointmentSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Text("This is Appointment Second Screen")]),
    );
  }
}

class AppointmentSecondPage extends StatelessWidget {
  const AppointmentSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentSecondCubit(),
      child: const AppointmentSecondScreen(),
    );
  }
}
