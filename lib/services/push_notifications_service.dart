// SHA1= C2:3C:B9:B3:1E:AB:07:F6:1C:83:CE:C2:24:17:A9:68:21:FF:3E:D0

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    // print('Background Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}