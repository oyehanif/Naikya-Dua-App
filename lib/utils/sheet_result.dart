import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sheet_result.freezed.dart';

@freezed
class SheetResult<T> with _$SheetResult<T> {
  const factory SheetResult.success({required T data}) = Success<T>;

  const factory SheetResult.failure({required String error}) =Failure<T>;
}