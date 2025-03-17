import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/enrollment_remote_data_source.dart';
import 'package:efk_academy/domain/repositories/enrollment_repository.dart';
import 'package:fpdart/fpdart.dart';

class EnrollmentRepositoryImpl implements EnrollmentRepository {
  const EnrollmentRepositoryImpl(this.enrollmentRemoteDataSource);

  final EnrollmentRemoteDataSource enrollmentRemoteDataSource;

  @override
  Future<Either<Failure, bool>> getEnrollment(String courseId) async {
    try {
      final isEnrolled =
          await enrollmentRemoteDataSource.getEnrollment(courseId);

      return right(isEnrolled);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
