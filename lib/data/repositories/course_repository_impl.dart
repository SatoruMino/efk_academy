import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/course_remote_data_source.dart';
import 'package:efk_academy/domain/entities/course.dart';
import 'package:efk_academy/domain/repositories/course_repository.dart';
import 'package:fpdart/fpdart.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  const CourseRepositoryImpl(this.courseRemoteDataSource);

  @override
  Future<Either<Failure, List<Course>>> getCourse() async {
    try {
      final courses = await courseRemoteDataSource.getCourse();

      return right(courses);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Course>>> getTrendingCourse() async {
    try {
      final courses = await courseRemoteDataSource.getTrendingCourse();

      return right(courses);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Course>>> searchCourseByCategory(
      String category) async {
    try {
      final courses =
          await courseRemoteDataSource.searchCourseByCategory(category);

      return right(courses);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Course>>> searchCourseByName(String name) async {
    try {
      final course = await courseRemoteDataSource.searchCourseByName(name);

      return right(course);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
