import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/course.dart';
import 'package:efk_academy/domain/repositories/course_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTrendingCourse implements Usecase<List<Course>, NoParam> {
  final CourseRepository courseRepository;

  const GetTrendingCourse(this.courseRepository);

  @override
  Future<Either<Failure, List<Course>>> call(NoParam param) async {
    return await courseRepository.getTrendingCourse();
  }
}
