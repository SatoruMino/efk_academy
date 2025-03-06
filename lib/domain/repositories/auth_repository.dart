import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signInWithPassword(
    String email,
    String password,
  );
  Future<Either<Failure, User>> signUpWithPassword(
    String username,
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();
}
