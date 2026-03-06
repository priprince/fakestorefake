import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appointment_first_state.dart';

class AppointmentFirstCubit extends Cubit<AppointmentFirstState> {
  AppointmentFirstCubit() : super(AppointmentFirstInitial());
}
