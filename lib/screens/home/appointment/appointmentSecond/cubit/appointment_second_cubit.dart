import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appointment_second_state.dart';

class AppointmentSecondCubit extends Cubit<AppointmentSecondState> {
  AppointmentSecondCubit() : super(AppointmentSecondInitial());
}
