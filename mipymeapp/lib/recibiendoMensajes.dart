import 'package:firebase_messaging/firebase_messaging.dart';

class recibiendomensajes{

  FirebaseMessaging mensaje = FirebaseMessaging.instance;

  notificaciones(){
    mensaje.requestPermission();
    mensaje.getToken().then((token) {
      print("------- TOKEN -------");
      print(token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) { // Cuando la aplicación está abierta

    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) { // Cuando la aplicación está en segundo plano

    }) ;
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async { // Cuando la aplicación está cerrada

    });
  }
}