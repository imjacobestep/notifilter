import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:notifilter_1/models/filters.dart';
import 'package:flutter/services.dart';

final flutterForegroundTask = FlutterForegroundTask.instance.init(
    notificationOptions: NotificationOptions(
      channelId: 'notification_channel_id',
      channelName: 'Foreground Notification',
      channelDescription: 'This notification appears when a foreground task is running.',
      channelImportance: NotificationChannelImportance.MIN,
      priority: NotificationPriority.DEFAULT,
    ),
  foregroundTaskOptions: ForegroundTaskOptions(
    interval: 10000
  ),
);

//AndroidNotificationListener _notifications;
//StreamSubscription<NotificationEventV2> _subscription;
List<Filter> currentFilters = [];
const _channel = const EventChannel('notifications');
typedef void Listener(dynamic data);
typedef void CancelListening();

CancelListening startListening(Listener listener){
  var subscription = _channel.receiveBroadcastStream().listen(listener, cancelOnError: true);
  return () {
    subscription.cancel();
  };
}

void startForegroundTask(){
  //IntentFilter intentFilter = new IntentFilter();
  //initPlatformState();
  flutterForegroundTask.start(
      notificationTitle: 'Foreground task is running',
      notificationText: 'Tap to return to the app',
      taskCallback: (DateTime timestamp){
        //startListening();
        print('timestamp: $timestamp');
      }
  );
}

void stopForegroundTask(){
  flutterForegroundTask.stop();
}

/*
Future<void> initPlatformState() async {
  startListening();
}

void onData(NotificationEventV2 event) {
  print(event);
  print('converting package extra to json');
  var jsonDatax = json.decode(event.packageExtra);
  print(jsonDatax);
}

void saveNoti(NotificationEventV2 event, int index){



}

void startListening() {
  _notifications = new AndroidNotificationListener();
  try {
    _subscription = _notifications.notificationStream.listen(onData);
  } on NotificationExceptionV2 catch (exception) {
    print(exception);
  }
}

void stopListening() {
  _subscription.cancel();
}*/
















