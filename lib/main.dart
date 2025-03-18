import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart'; // Import this

import 'app.dart';
import 'simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await _requestPermissions(); // Call permissions before removing splash screen
  
  FlutterNativeSplash.remove();

  runApp(const PrivateClassMobileApp());
}


Future<void> _requestPermissions() async {
  await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.locationWhenInUse,
  ].request();
}
