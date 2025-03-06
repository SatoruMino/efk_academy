import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/datasources/poster_remote_data_source.dart';
import 'package:efk_academy/domain/entities/poster.dart';
import 'package:efk_academy/domain/repositories/poster_repository.dart';
import 'package:fpdart/fpdart.dart';

class PosterRepositoryImpl implements PosterRepository {
  final PosterRemoteDataSource posterRemoteDataSource;

  const PosterRepositoryImpl(this.posterRemoteDataSource);

  @override
  Future<Either<Failure, List<Poster>>> getPosters() async {
    try {
      final posters = await posterRemoteDataSource.getPosters();

      return right(posters);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
