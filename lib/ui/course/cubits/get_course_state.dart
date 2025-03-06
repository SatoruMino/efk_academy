part of 'get_course_cubit.dart';

@immutable
sealed class GetCourseState {}

final class GetCourseInitial extends GetCourseState {}

final class GetCourseInProgress extends GetCourseState {}

final class GetCourseFailure extends GetCourseState {
  final String message;
  GetCourseFailure(this.message);
}

final class GetCourseSuccess extends GetCourseState {
  final List<Course> courses;
  GetCourseSuccess(this.courses);
}
