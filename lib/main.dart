import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:leave_the_house_app/app.dart';
import 'package:leave_the_house_app/reminders/view/reminders_page.dart';
import 'package:leave_the_house_app/utils/notification_service.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  NotificationService notificationService = NotificationService();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await notificationService.localNotificationsPlugin
          .getNotificationAppLaunchDetails();
  final didNotificationLaunchApp =
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  LeaveTheHouseAppView.initialRoute =
      didNotificationLaunchApp ? MySecondScreen.routeName : HomePage.routeName;

  HydratedBlocOverrides.runZoned(() => runApp(LeaveTheHouseApp()),
      storage: storage);
}
