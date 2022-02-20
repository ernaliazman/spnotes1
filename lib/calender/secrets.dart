import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID = "";
  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.ANDROID_CLIENT_ID ;

}
