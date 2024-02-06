import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:gsheets/gsheets.dart';
import 'package:hive/hive.dart';

import 'dua_hive_model.dart';

const key = 'categoryKey';

class DuaHive {
  DuaHive._();

  static var duaBox = Hive.box('dua');

  // static var userBox = Hive.box<List<DuaHiveModel>>('dua');
  static List<DuaHiveModel> duaList = [];

  static void saveDuaList(List<DuaHiveModel> values) {
    duaBox.put(key, values);
  }

  static List<DuaHiveModel> getAllUsers() {
    duaList = duaBox.get(key);
    return duaList;
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
