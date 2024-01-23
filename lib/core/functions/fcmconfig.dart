// request permition to send notification
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

requestnotificationpermition() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

fcmconfig() {
  FirebaseMessaging.onMessage.listen((remotemessage) {
    print("--------------------notification---------------");
    print(remotemessage.notification!.title);
    print(remotemessage.notification!.body);
    print("--------------------notification----ffffffffffffff-----------");
    print(remotemessage.data);
    print(
        "--------------------notification-- ${Get.currentRoute}---------ffffffffffffffff----");
    Get.snackbar(remotemessage.notification!.title.toString(),
        remotemessage.notification!.body.toString());
    // FlutterRingtonePlayer.playRingtone();
    // FlutterRingtonePlayer.play(android: AndroidSounds.ringtone);
    // FlutterRingtonePlayer.playNotification(
    //   // looping: true,
    //   volume: 100,
    //   asAlarm: true,
    // );
    // if (Get.currentRoute == "/pendingorder") {
    //   Pendingorderscontroller controller = Get.find();
    //   controller.refreshpage();
    // }
  });
}
