import 'package:dua/gsheet/quran_model.dart';
import 'package:dua/hive/dua_hive_model.dart';
import 'package:dua/ui/screens/TestScreen.dart';
import 'package:dua/ui/screens/dua_list.dart';
import 'package:dua/ui/screens/language_selection_screen.dart';
import 'package:dua/ui/screens/dua_detail.dart';
import 'package:dua/ui/screens/qalmas_screen.dart';
import 'package:dua/ui/screens/quran_para_list_screen.dart';
import 'package:dua/ui/screens/tasbhi_screen.dart';
import 'package:dua/ui/screens/youtube_player_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:dua/ui/screens/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      name: 'details',
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        return DuaDetailScreen(
          type: state.extra as MyDuaDetailCustomType,
        );
      },
    ),
    GoRoute(
      name: 'duaList',
      path: '/duaList',
      builder: (BuildContext context, GoRouterState state) {
        return const DuaListScreen();
      },
    ),
    GoRoute(
      name: 'qalmas',
      path: '/qalmas',
      builder: (BuildContext context, GoRouterState state) {
        return const QalmasScreen();
      },
    ),
    GoRoute(
      name: 'quran',
      path: '/quran',
      builder: (BuildContext context, GoRouterState state) {
        return const QuranParaListScreen();
      },
    ),

    GoRoute(
      name: 'test',
      path: '/test/:test',
      builder: (context, state) {
        return TestScreen(
          test: state.pathParameters['test'],
        );
      },
    ),
    GoRoute(
      name: 'languageSelection',
      path: '/languageSelection',
      builder: (context, state) {
        return const LanguageSelectionScreen();
      },
    ),

    GoRoute(
      name: 'youtubePlayer',
      path: '/youtubePlayer',
      builder: (BuildContext context, GoRouterState state) {
        return YoutubePlayerScreen(
          quranModel: state.extra as QuranModel,
        );
      },
    ),

    GoRoute(
      name: 'tasbih',
      path: '/tasbih',
      builder: (BuildContext context, GoRouterState state) {
        return const TasbihScreen(
        );
      },
    ),
  ],
);

class MyDuaDetailCustomType {
  final DuaHiveModel model;
  final bool isQalmas;
  final Function() isClick;

  MyDuaDetailCustomType({required this.model, required this.isQalmas, required this.isClick});
}
