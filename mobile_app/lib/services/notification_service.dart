import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'api_client.dart';
import '../config/app_config.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final ApiClient _apiClient = ApiClient();
  
  static Future<void> initialize() async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted notification permission');
    } else {
      print('User declined or has not accepted notification permission');
    }
    
    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleNotificationTap(details);
      },
    );
    
    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print('FCM Token: $token');
      await registerToken(token);
    }
    
    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen(registerToken);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
    
    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification caused app to open from background');
      _handleNotificationMessage(message);
    });
    
    // Check if app was opened from a notification
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationMessage(initialMessage);
    }
  }
  
  static Future<void> registerToken(String token) async {
    try {
      await _apiClient.callMethod(
        AppConfig.registerDeviceEndpoint,
        args: {
          'token': token,
          'device_type': 'mobile',
        },
      );
      print('FCM token registered with backend');
    } catch (e) {
      print('Error registering FCM token: $e');
    }
  }
  
  static Future<void> unregisterToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await _apiClient.callMethod(
          AppConfig.unregisterDeviceEndpoint,
          args: {'token': token},
        );
      }
      await _firebaseMessaging.deleteToken();
      print('FCM token unregistered');
    } catch (e) {
      print('Error unregistering FCM token: $e');
    }
  }
  
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'hrms_notifications',
      'HRMS Notifications',
      channelDescription: 'Notifications for HRMS application',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );
    
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'HRMS Notification',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
  }
  
  static void _handleNotificationTap(NotificationResponse details) {
    print('Notification tapped: ${details.payload}');
    // Navigate to appropriate screen based on payload
    // This will be handled by the router
  }
  
  static void _handleNotificationMessage(RemoteMessage message) {
    print('Handling notification message: ${message.data}');
    // Extract reference_document_type and reference_document_name
    // Navigate to appropriate screen
    final data = message.data;
    if (data.containsKey('reference_document_type') &&
        data.containsKey('reference_document_name')) {
      final docType = data['reference_document_type'];
      final docName = data['reference_document_name'];
      print('Navigate to $docType: $docName');
      // Implement navigation logic based on docType
    }
  }
}
