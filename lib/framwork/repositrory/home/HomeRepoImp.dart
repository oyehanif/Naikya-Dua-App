import 'package:dua/framwork/repositrory/home/HomeRepo.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:dua/hive/dua_hive_model.dart';
import 'package:dua/hive/dua_hive.dart';
import 'package:dua/utils/sheet_result.dart';

class HomeRepoImp implements HomeRepo {
  @override
  Future<SheetResult> getDuaList() async {
    try {
      List<DuaHiveModel> list  = DuaHive.getAllUsers();
      if (list.isEmpty) {
        var data = await DuaSheetsApi.getAllDua();
        for (var element in data) {
          list.add(DuaHiveModel(duaName: element.duaName, dua: element.dua, tarjum: element.tarjum ,id: element.id));
        }
        DuaHive.saveDuaList(list);
        list = DuaHive.getAllUsers();
      }else{
        print("Data From Local");
      }
      return SheetResult.success(data: list);
    } catch (e) {
      return SheetResult.failure(error: e.toString());
    }
  }
}
