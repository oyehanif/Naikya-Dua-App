
import 'package:dua/utils/sheet_result.dart';

abstract class QuranRepo {
  Future<SheetResult> getQuranList();
}