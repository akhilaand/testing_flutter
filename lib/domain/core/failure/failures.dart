import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';
@freezed
class Failures with _$Failures{
  const factory Failures.clientFailure() = _ClientFailure;
  const factory Failures.serverFailure() = _serverFailure;
  
}