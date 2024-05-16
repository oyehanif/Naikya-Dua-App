import 'package:dua/framwork/repositrory/quran/QuranRepo.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:dua/gsheet/quran_model.dart';
import 'package:dua/hive/dua_hive.dart';
import 'package:dua/utils/sheet_result.dart';

class QuranRepoImp extends QuranRepo {
  @override
  Future<SheetResult> getQuranList() async {
    await DuaSheetsApi.init();
    try {
      List<QuranModel> list = DuaHive.getQuranList();
      if (list.isEmpty) {
        var data = await DuaSheetsApi.getAllQuran();
        for (var element in data) {
          list.add(QuranModel(
              no: element.no, name: element.name, link: element.link));
        }
        DuaHive.saveQuranList(list);
        list = DuaHive.getQuranList();
      } else {
        print("Data From Local");
      }
      return SheetResult.success(data: list);
    } catch (e) {
      return SheetResult.failure(error: e.toString());
    }
  }
}
