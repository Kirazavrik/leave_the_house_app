import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../reminders/view/reminders_page.dart';
import '../utils/notification_service.dart';
import 'notification_cubit.dart';

class NotificationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationView();
}

class _NotificationView extends State<NotificationView> {
  late final NotificationService notificationService;
  String? _selectedTime;
  TimeOfDay? _timeOfDay;

  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
    super.initState();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.pushNamed(context, MySecondScreen.routeName);
      });


  Future<void> _showTimePicker() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      context.read<NotificationCubit>().changeTime(result);

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Card(
          child: Column(
            children: [
              Text('Время выхода из дома'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showTimePicker();
                    },
                    child: Builder(builder: (BuildContext context) {
                      switch (state.status) {
                        case NotificationStatus.initial:
                          return Text(
                            state.time.format(context),
                            style: const TextStyle(fontSize: 30),
                          );
                        case NotificationStatus.timeChanged:
                          return Text(
                            state.time.format(context),
                            style: const TextStyle(fontSize: 30),
                          );
                      }
                      return Container();
                    }),
                  ),
                  Switch(
                      value: state.isEnabled,
                      onChanged: (value) {
                        setState(() {
                          if(state.isEnabled == false) {
                            context.read<NotificationCubit>().enableNotification();
                            print(state.isEnabled);
                          } else {
                            context.read<NotificationCubit>().disableNotification();
                            print(state.isEnabled);
                          }
                        });
                  })
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

