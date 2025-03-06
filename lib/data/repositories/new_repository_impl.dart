import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/new_remote_data_source.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:efk_academy/domain/repositories/new_repository.dart';
import 'package:fpdart/fpdart.dart';

class NewRepositoryImpl implements NewRepository {
  final NewRemoteDataSource newRemoteDataSource;

  const NewRepositoryImpl(this.newRemoteDataSource);

  @override
  Future<Either<Failure, List<New>>> getNew() async {
    try {
      final news = await newRemoteDataSource.getNew();

      return right(news);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
