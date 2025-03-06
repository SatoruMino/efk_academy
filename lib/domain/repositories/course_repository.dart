import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/course.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CourseRepository {
  Future<Either<Failure, List<Course>>> getCourse();
  Future<Either<Failure, List<Course>>> getTrendingCourse();
  Future<Either<Failure, List<Course>>> searchCourseByName(String name);
  Future<Either<Failure, List<Course>>> searchCourseByCategory(String category);
}
