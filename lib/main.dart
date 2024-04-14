import 'dart:async';

import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:dua/utils/fetchAudio.dart';
import 'package:flutter/material.dart';
import 'package:dua/route/route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive/dua_hive_model.dart';

late String test;

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DuaSheetsApi.init();
    await Hive.initFlutter();
    Hive.registerAdapter(DuaHiveModelAdapter());
    await Hive.openBox<DuaHiveModel>('dua');
    await Hive.openBox<DuaHiveModel>('qalmas');
    runApp(const ProviderScope(child: MyApp()));
    test = await downloadFile();
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
