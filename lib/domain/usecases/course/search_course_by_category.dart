import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/course.dart';
import 'package:efk_academy/domain/repositories/course_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchCourseByCategory implements Usecase<List<Course>, String> {
  final CourseRepository courseRepository;

  const SearchCourseByCategory(this.courseRepository);

  @override
  Future<Either<Failure, List<Course>>> call(String param) async {
    return await courseRepository.searchCourseByCategory(param);
  }
}
