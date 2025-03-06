import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/user_remote_data_source.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  const UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final user = await userRemoteDataSource.getUser();

      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User>> changeUsername(String username) async {
    try {
      final user = await userRemoteDataSource.changeUsername(username);

      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final user = await userRemoteDataSource.changePassword(
        currentPassword,
        newPassword,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
