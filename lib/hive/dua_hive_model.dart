import 'dart:ffi';

import 'package:hive/hive.dart';

part 'dua_hive_model.g.dart';

@HiveType(typeId: 0)
class DuaHiveModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String duaName;
  @HiveField(2)
  final String dua;
  @HiveField(3)
  final String tarjum;
  @HiveField(4)
  final bool isFav;

  DuaHiveModel(
      {required this.id,
      required this.duaName,
      required this.dua,
      required this.tarjum,
      this.isFav = false});

  DuaHiveModel copyWith({id, duaName, dua, tarjum, isFav}) {
    return DuaHiveModel(
        id: this.id,
        duaName: this.duaName,
        dua: this.dua,
        tarjum: this.tarjum,
        isFav: isFav);
  }
}
