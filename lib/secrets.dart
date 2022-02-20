import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID = "";
  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.ANDROID_CLIENT_ID ;

}

// 911532803889-l3bfhs8pudtdplithk4mtnb8ekuvq03s.apps.googleusercontent.com
