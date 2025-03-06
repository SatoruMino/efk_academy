import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/poster.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class PosterRepository {
  Future<Either<Failure, List<Poster>>> getPosters();
}
