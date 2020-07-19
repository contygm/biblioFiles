import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // needed for systemChrome service
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // set the orienations so app will work in multiple views
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(App());
}

