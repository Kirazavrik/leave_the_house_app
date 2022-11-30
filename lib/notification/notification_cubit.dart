import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leave_the_house_app/utils/converters.dart';
import 'package:leave_the_house_app/utils/notification_service.dart';

part 'notification_state.dart';
part 'notification_cubit.g.dart';


class NotificationCubit extends HydratedCubit<NotificationState> {
  NotificationCubit() : super(NotificationState());

  NotificationService notificationService = NotificationService();

  Future<void> changeTime(TimeOfDay timeOfDay) async {
    try {
      if(state.isEnabled == true) {
        await notificationService.localNotificationsPlugin.cancelAll();
        await notificationService.showScheduledLocalNotification(timeOfDay: timeOfDay);
        emit(state.copyWith(
            time: timeOfDay, status: NotificationStatus.timeChanged));
      }
      emit(state.copyWith(
          time: timeOfDay, status: NotificationStatus.timeChanged));
    } on Exception {
      emit(state.copyWith(status: NotificationStatus.failure));
    }
  }

  void enableNotification() async {
    await notificationService.showScheduledLocalNotification(timeOfDay: state.time);
    emit(state.copyWith(isEnabled: true));
  }

  void disableNotification() async {
    await notificationService.localNotificationsPlugin.cancelAll();
    emit(state.copyWith(isEnabled: false));
  }

  @override
  NotificationState? fromJson(Map<String, dynamic> json) => NotificationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NotificationState state) => state.toJson();

}
