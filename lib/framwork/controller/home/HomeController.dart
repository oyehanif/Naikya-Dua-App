import 'package:dua/framwork/repositrory/home/HomeRepo.dart';
import 'package:dua/framwork/repositrory/home/HomeRepoImp.dart';
import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/hive/dua_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = ChangeNotifierProvider<HomeController>(
    (ref) => HomeController(HomeRepoImp()));

class HomeController extends ChangeNotifier {
  HomeRepo repo;

  HomeController(this.repo);

  List<DuaHiveModel> allDuaList = [];
  List<DuaHiveModel> favDuaList = [];
  List<DuaHiveModel> qalmasList = [];

  void getAllDua() async {
    final result = await repo.getDuaList();
    allDuaList.clear();
    result.when(
        success: (data) {
          if (allDuaList.isEmpty) {
            allDuaList.addAll(data as List<DuaHiveModel>);
            favDuaList = allDuaList.where((i) => i.isFav).toList();
            notifyListeners();
          }
          print("Here Data : ${data.length}");
        },
        failure: (error) {});
  }


  void getALlQalmas() async {
    final result = await repo.getQalmasList();
    qalmasList.clear();
    result.when(
        success: (data) {
          if (qalmasList.isEmpty) {
            qalmasList.addAll(data as List<DuaHiveModel>);
            notifyListeners();
          }
          print("Here Data of qalmas: ${data.length}");
        },
        failure: (error) {});
  }
}
