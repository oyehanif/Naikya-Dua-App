import 'dart:ffi';

import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:gsheets/gsheets.dart';
import 'package:hive/hive.dart';

import 'dua_hive_model.dart';

const key = 'categoryKey';
const favKey = 'FavKey';

class DuaHive {
  DuaHive._();

  static var duaBox = Hive.box<DuaHiveModel>('dua');

  // static var userBox = Hive.box<List<DuaHiveModel>>('dua');
  static List<DuaHiveModel> duaList = [];

  static void saveDuaList(List<DuaHiveModel> values, {bool isFav = false}) {
      duaBox.addAll(values);
  }

  static List<DuaHiveModel> getAllUsers() {
    duaList = duaBox.values.toList().asMap().entries.map((e){
      e.value.id = e.key;
      print("Here Key  ${e.value.id}  Key  ${e.key}");
          return e.value;
    }).toList();
    // duaList = duaBox.get(key, defaultValue: []).cast<DuaHiveModel>();
    return duaList;
  }

  static void update(int index ,DuaHiveModel model) {
    try {
      duaBox.putAt(index, model);
    } catch (e) {
      print("Here : from update $e");
    }
  }

//  static void getAllUsers()  {
//   duaList = duaBox.get(key) ?? [];
//   // if(duaList.isEmpty){
//   //   var data = await DuaSheetsApi.getAllDua();
//   //   for (var element in data) {
//   //     duaList.add(DuaHiveModel(duaName: element.duaName, dua: element.dua, tarjum: element.tarjum ,id: element.id));
//   //   }
//   //   DuaHive.saveDuaList(duaList);
//   // }
//   // print("Here For Hive : ${duaList.length}");
// }
}
