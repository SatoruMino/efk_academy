import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Stream<User> get getUser;
  Future<Either<Failure, User>> signIn(String email, String password);
  Future<Either<Failure, User>> signUp(
    String username,
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, void>> changeUsername(String username);
  Future<Either<Failure, void>> changePassword(
    String password,
    String newPassword,
  );
}
