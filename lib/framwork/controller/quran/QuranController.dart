import 'package:dua/framwork/repositrory/home/HomeRepo.dart';
import 'package:dua/framwork/repositrory/home/HomeRepoImp.dart';
import 'package:dua/framwork/repositrory/quran/QuranRepo.dart';
import 'package:dua/framwork/repositrory/quran/QuranRepoImp.dart';
import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/gsheet/quran_model.dart';
import 'package:dua/hive/dua_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quranProvider = ChangeNotifierProvider<QuranController>(
    (ref) => QuranController(QuranRepoImp()));

class QuranController extends ChangeNotifier {
  QuranRepo repo;

  QuranController(this.repo);

  List<QuranModel> quranList = [];

  void getQuranList() async {
    final result = await repo.getQuranList();
    quranList.clear();
    result.when(
        success: (data) {
          if (quranList.isEmpty) {
            quranList.addAll(data as List<QuranModel>);
            notifyListeners();
          }
          print("Here Data : ${data.length}");
        },
        failure: (error) {});
  }
}
