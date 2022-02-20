import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID = "33289169484-8a6oo9bk0b68l839imo5qouoq13hv3fa.apps.googleusercontent.com";
  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.ANDROID_CLIENT_ID ;

}