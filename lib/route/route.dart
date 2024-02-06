import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/ui/screens/TestScreen.dart';
import 'package:dua/ui/screens/dua_list_screen.dart';
import 'package:dua/ui/screens/language_selection_screen.dart';
import 'package:dua/ui/screens/dua_detail.dart';
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
          model: state.extra as duaModel,
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
  ],
);
