import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(ReminderInitial());
}
