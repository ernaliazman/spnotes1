import 'package:flutter/material.dart';
import 'package:projectapp/authenticate/homescreen.dart';

import 'package:projectapp/screens/dashboard_screen.dart';
import 'package:projectapp/secrets.dart';
import 'package:projectapp/utils/calendar_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'dart:io' show Platform;

import 'login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _clientID = new ClientId(Secret.getId(), "");
  const _scopes = [cal.CalendarApi.calendarScope];
  await clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) async {
    CalendarClient.calendar = cal.CalendarApi(client);
  });

  runApp(MyApp());
}

void prompt(String url) async {
  // if (await canLaunch(url)) {
    await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
