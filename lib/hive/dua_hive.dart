import 'dart:ffi';

import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:dua/gsheet/quran_model.dart';
import 'package:gsheets/gsheets.dart';
import 'package:hive/hive.dart';

import 'dua_hive_model.dart';

const key = 'categoryKey';
const favKey = 'FavKey';
const countKey = 'CountKey';

class DuaHive {
  DuaHive._();


  static var duaBox = Hive.box<DuaHiveModel>('dua');
  static var qalmasBox = Hive.box<DuaHiveModel>('qalmas');
  static var quranBox = Hive.box<QuranModel>('quran');
  static var tasbhiCount = Hive.box<int>('tasbhi');

  // static var userBox = Hive.box<List<DuaHiveModel>>('dua');
  static List<DuaHiveModel> duaList = [];
  static List<DuaHiveModel> qalmasList = [];
  static List<QuranModel> quranList = [];

  static void saveDuaList(List<DuaHiveModel> values, {bool isFav = false}) {
      duaBox.addAll(values);
  }

  static List<DuaHiveModel> getAllDuas() {
    duaList = duaBox.values.toList().asMap().entries.map((e){
      e.value.id = e.key;
      print("Here Key  ${e.value.id}  Key  ${e.key}");
          return e.value;
    }).toList();
    // duaList = duaBox.get(key, defaultValue: []).cast<DuaHiveModel>();
    return duaList;
  }

  static void updateDua(int index ,DuaHiveModel model) {
    try {
      duaBox.putAt(index, model);
    } catch (e) {
      print("Here : from update $e");
    }
  }


  /// Qalmas Hive Methos

  static void saveQalmasList(List<DuaHiveModel> values, {bool isFav = false}) {
    qalmasBox.addAll(values);
  }

  static List<DuaHiveModel> getQalmasDuas() {
    qalmasList = qalmasBox.values.toList().asMap().entries.map((e){
      e.value.id = e.key;
      print("Here Key  ${e.value.id}  Key  ${e.key}");
      return e.value;
    }).toList();
    // duaList = duaBox.get(key, defaultValue: []).cast<DuaHiveModel>();
    return qalmasList;
  }


  ///Quran Hive Methods

  static void saveQuranList(List<QuranModel> values, {bool isFav = false}) {
    quranBox.addAll(values);
  }

  static List<QuranModel> getQuranList() {
    quranList = quranBox.values.toList().asMap().entries.map((e){
      e.value.no = e.key;
      return e.value;
    }).toList();
    // duaList = duaBox.get(key, defaultValue: []).cast<DuaHiveModel>();
    return quranList;
  }

  ///Tasbhi Count
  static void saveCount(int count){
    tasbhiCount.put(countKey,count);
    print(count);
  }

  static int getCount() => tasbhiCount.get(countKey) ?? 0;


}
