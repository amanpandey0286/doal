import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

String _alarmTitle = '';

class AlarmManager {
  static Future<void> setAlarm(
    String taskId,
    String dateText,
    String timeText,
    String title,
  ) async {
    _alarmTitle = title;
    final dateSplit = dateText.split('-');
    final timeSplit = timeText.split(':');

    final year = int.parse(dateSplit[0]);
    final month = int.parse(dateSplit[1]);
    final day = int.parse(dateSplit[2]);
    final hour = int.parse(timeSplit[0]);
    final minute = int.parse(timeSplit[1]);

    final alarmDateTime = DateTime(year, month, day, hour, minute);

    await AndroidAlarmManager.oneShotAt(
      alarmDateTime,
      taskId.hashCode,
      _alarmCallback,
      exact: true,
      wakeup: true,
    );
  }

  static Future<void> cancelAlarm(String taskId) async {
    await AndroidAlarmManager.cancel(taskId.hashCode);
  }

  static void _alarmCallback() async {
    print('Alarm fired for $_alarmTitle'); // Log the title received

    final notificationController = NotificationController();
    await notificationController.createCustomNotification(
      id: 10,
      title: _alarmTitle,
      body: 'Your alarm has triggered!',
    );
  }
}

class NotificationController {
  @pragma('vm:entry-point')
  Future<void> createCustomNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: title,
        body: body,
      ),
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}
}
