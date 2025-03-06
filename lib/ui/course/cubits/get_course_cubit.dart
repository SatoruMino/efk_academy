import 'package:efk_academy/core/usecase/usecase.dart';
import 'package:efk_academy/domain/entities/course.dart';
import 'package:efk_academy/domain/usecases/course/get_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_course_state.dart';

class GetCourseCubit extends Cubit<GetCourseState> {
  GetCourseCubit({
    required GetCourse getCourse,
  })  : _getCourse = getCourse,
        super(GetCourseInitial());

  final GetCourse _getCourse;

  Future<void> getCourses() async {
    emit(GetCourseInProgress());

    final res = await _getCourse(NoParam());

    res.fold(
      (l) => emit(
        GetCourseFailure(
          l.message,
        ),
      ),
      (courses) => emit(
        GetCourseSuccess(
          courses,
        ),
      ),
    );
  }
}
