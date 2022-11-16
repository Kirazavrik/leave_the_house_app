import 'package:flutter/material.dart';
import 'package:leave_the_house_app/utils/notification_service.dart';

class RemindersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RemindersView(),
    );
  }
}

class RemindersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RemindersView();
}

class _RemindersView extends State<RemindersView> {
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MySecondScreen(payload: payload)));
      });

  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
        _timeOfDay = result!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            _selectedTime != null ? _selectedTime! : 'No time selected!',
            style: const TextStyle(fontSize: 30),
          ),
          ElevatedButton(
              onPressed: _show,
              child: Text('hit me')
          ),
          ElevatedButton(
            onPressed: () async {
              await notificationService.showScheduledLocalNotification(
                  id: 0,
                  title: 'shedulw',
                  body: 'some body',
                  payload: 'hoorAY',
                  timeOfDay: _timeOfDay!);
            },
            child: Text('press'),
          ),
        ],
      ),
    );
  }
}

class MySecondScreen extends StatelessWidget {
  final String payload;
  const MySecondScreen({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JustWater"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('some text'),
          Center(
            child: Text(payload),
          ),
        ],
      ),
    );
  }
}
