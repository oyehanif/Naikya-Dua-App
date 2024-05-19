import 'dart:async';
import 'dart:ffi';

import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:dua/gsheet/quran_model.dart';
import 'package:dua/utils/fetchAudio.dart';
import 'package:flutter/material.dart';
import 'package:dua/route/route.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive/dua_hive_model.dart';import 'package:flutter_native_splash/flutter_native_splash.dart';

late String test;

void main() async {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Hive.initFlutter();
    Hive.registerAdapter(DuaHiveModelAdapter());
    await Hive.openBox<DuaHiveModel>('dua');
    await Hive.openBox<DuaHiveModel>('qalmas');
    await Hive.openBox<QuranModel>('quran');
    await Hive.openBox<int>('tasbhi');
    runApp(const ProviderScope(child: MyApp()));
    FlutterNativeSplash.remove();
  },catchUnhandledExceptions);
}


void catchUnhandledExceptions(Object error, StackTrace? stack) {
  print("Error From RunZoneGuarder :${error.toString()}");
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      routerConfig: router,
    );
  }
}
