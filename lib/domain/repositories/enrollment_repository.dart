import 'package:efk_academy/core/core.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EnrollmentRepository {
  Future<Either<Failure, bool>> getEnrollment(String courseId);
}
