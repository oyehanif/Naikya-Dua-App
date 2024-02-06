import 'package:dua/framwork/repositrory/home/HomeRepoImp.dart';
import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/utils/sheet_result.dart';

abstract class HomeRepo {
  // factory HomeRepo() => HomeRepoImp();
  Future<SheetResult> getDuaList();
}