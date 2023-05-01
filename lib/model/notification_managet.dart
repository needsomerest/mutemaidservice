import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_logo');

    DarwinInitializationSettings initializationIos =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationIos);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> simpleNotificationShow() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'EjrH3vIPBAdtuMBBTpTXmzb0Pil2',
      'Channel_title',
      priority: Priority.high,
      importance: Importance.max,
      icon: 'app_logo',
      channelShowBadge: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(
        0, 'Simple Notification', 'New User send message', notificationDetails);
  }

  Future<void> bigPictureNotificationShow() async {
    BigPictureStyleInformation bigPictureStyleInformation =
        const BigPictureStyleInformation(
            DrawableResourceAndroidBitmap('app_logo'),
            contentTitle: 'Code Compilee',
            largeIcon: DrawableResourceAndroidBitmap('app_logo'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('big_picture_id', 'big_picture_title',
            priority: Priority.high,
            importance: Importance.max,
            styleInformation: bigPictureStyleInformation);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(
        1, 'Big Picture Notification', 'New Message', notificationDetails);
  }

  Future<void> multipleNotificationShow() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('Channel_id', 'Channel_title',
            priority: Priority.high,
            importance: Importance.max,
            groupKey: 'commonMessage');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    notificationsPlugin.show(
        0, 'New Notification', 'User 1 send message', notificationDetails);

    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        notificationsPlugin.show(
            1, 'New Notification', 'User 2 send message', notificationDetails);
      },
    );

    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        notificationsPlugin.show(
            2, 'New Notification', 'User 3 send message', notificationDetails);
      },
    );

    List<String> lines = ['user1', 'user2', 'user3'];

    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
        contentTitle: '${lines.length} messages', summaryText: 'Code Compilee');

    AndroidNotificationDetails androidNotificationSpesific =
        AndroidNotificationDetails('groupChennelId', 'groupChennelTitle',
            styleInformation: inboxStyleInformation,
            groupKey: 'commonMessage',
            setAsGroupSummary: true);
    NotificationDetails platformChannelSpe =
        NotificationDetails(android: androidNotificationSpesific);
    await notificationsPlugin.show(
        3, 'Attention', '${lines.length} messages', platformChannelSpe);
  }

//using for mute maid service app
  Future<void> NotificationBooking(
      {required String header,
      required String subheader,
      required String userid}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('Channel_id', 'Payment_Status',
            priority: Priority.high,
            importance: Importance.max,
            icon: 'app_logo',
            channelShowBadge: true);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(0, header, subheader, notificationDetails);
  }
}
