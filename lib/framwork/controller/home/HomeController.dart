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

  List<DuaHiveModel> productList = [];

  void getAllDua() async {
    final result = await repo.getDuaList();
    result.when(
        success: (data) {
          if (productList.isEmpty) {
            productList.addAll(data as List<DuaHiveModel>);
          }
          print("Here Data : ${data.length}");
        },
        failure: (error) {});
  }
}
