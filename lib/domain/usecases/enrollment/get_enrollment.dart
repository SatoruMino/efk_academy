import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/repositories/enrollment_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetEnrollment implements Usecase<bool, String> {
  const GetEnrollment(this.enrollmentRepository);

  final EnrollmentRepository enrollmentRepository;

  @override
  Future<Either<Failure, bool>> call(String param) async {
    return await enrollmentRepository.getEnrollment(param);
  }
}
