import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class NewRepository {
  Future<Either<Failure, List<New>>> getNew();
}
