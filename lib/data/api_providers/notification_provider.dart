import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class FCMConfig {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initAwesomeNotification() async {
    try {
      await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: AppColors.purpleColor,
            ledColor: AppColors.whiteColor,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            locked: true,
            defaultRingtoneType: DefaultRingtoneType.Notification,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group',
          ),
        ],
        debug: true,
      );
    } catch (e) {
      debugPrint('Failed to initialize Awesome Notifications: $e');
    }
  }

  Future<void> requestPermission() async {
    try {
      final bool isAllowed =
          await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    } catch (e) {
      debugPrint('Error requesting notification permissions: $e');
    }
  }

  int _notificationId = 0;
  Future<void> sendNotification({String? title, String? body}) async {
    _notificationId++;
    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: _notificationId,
          channelKey: 'basic_channel',
          title: title ?? 'No title provided',
          body: body ?? 'No body provided',
          notificationLayout: NotificationLayout.BigText,
          wakeUpScreen: true,
        ),
      );
    } catch (e) {
      debugPrint('Error creating notification: $e');
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }
}
