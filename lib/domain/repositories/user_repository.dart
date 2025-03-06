import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, User?>> getUser();
  Future<Either<Failure, User>> changeUsername(String username);
  Future<Either<Failure, User>> changePassword(
    String currentPassword,
    String newPassword,
  );
}
