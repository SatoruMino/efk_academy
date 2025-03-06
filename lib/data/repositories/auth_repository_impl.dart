import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/auth_remote_data_source.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> signInWithPassword(
    String email,
    String password,
  ) async {
    try {
      final user =
          await authRemoteDataSource.signInWithPassword(email, password);

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
  Future<Either<Failure, User>> signUpWithPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      final user = await authRemoteDataSource.signUpWithPassword(
        username,
        email,
        password,
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

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final user = await authRemoteDataSource.signOut();

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
