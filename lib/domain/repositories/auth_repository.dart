import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Stream<User> get getUser;
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> signUp(
    String username,
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> changeUsername(String username);
}
