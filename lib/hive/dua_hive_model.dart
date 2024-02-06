import 'package:hive/hive.dart';

part 'dua_hive_model.g.dart';

@HiveType(typeId: 0)
class DuaHiveModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String duaName;
  @HiveField(2)
  final String dua;
  @HiveField(3)
  final String tarjum;

  const DuaHiveModel(
      {required this.id,
        required this.duaName,
        required this.dua,
        required this.tarjum});
}