import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'simple_bloc_observer.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(const AlokaMobileView());
}
