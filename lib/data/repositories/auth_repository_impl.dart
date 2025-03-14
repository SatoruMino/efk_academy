import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/auth_remote_data_source.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.authRemoteDataSource);

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Stream<User> get getUser {
    return authRemoteDataSource.getUser.asyncMap((user) async {
      if (user == null) {
        return User.empty;
      }

      return user;
    });
  }

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    try {
      final response = await authRemoteDataSource.signIn(email, password);

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(
      String username, String email, String password) async {
    try {
      final response =
          await authRemoteDataSource.signUp(username, email, password);

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final respones = await authRemoteDataSource.signOut();

      return right(respones);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> changeUsername(String username) async {
    try {
      final response = await authRemoteDataSource.changeUsername(username);

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
