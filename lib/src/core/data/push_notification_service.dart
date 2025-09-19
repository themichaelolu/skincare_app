import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Request notification permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get the token
      String? token = await _firebaseMessaging.getToken();
      print('Firebase Token: $token');

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received foreground message');
        _handleForegroundMessage(message);
      });

      // Handle background messages when app is in background/terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message opened app');
        _handleBackgroundMessage(message);
      });

      // Optional: Handle initial message if app was terminated
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          _handleTerminatedMessage(message);
        }
      });
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Show local notification when app is in foreground
    // You might want to use a package like flutter_local_notifications
    if (message.notification != null) {
      print('Foreground message: ${message.notification!.title}');
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    // Navigate to specific screen based on notification
    if (message.data.containsKey('screen')) {
      // Example navigation logic
      // Navigator.pushNamed(context, message.data['screen']);
    }
  }

  void _handleTerminatedMessage(RemoteMessage message) {
    // Handle message when app is completely terminated
    print('App was terminated and opened from notification');
  }
}