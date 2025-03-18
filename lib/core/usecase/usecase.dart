import 'package:efk_academy/core/error/error.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

abstract interface class StreamUsecase<Type, Param> {
  Stream<Either<Failure, Type>> call(Param param);
}

class NoParam {}
