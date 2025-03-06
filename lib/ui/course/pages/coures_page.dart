import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/course/cubits/get_course_cubit.dart';
import 'package:efk_academy/ui/course_detail/pages/course_detail_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouresPage extends StatelessWidget {
  const CouresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: BlocBuilder<GetCourseCubit, GetCourseState>(
        builder: (context, state) {
          switch (state) {
            case GetCourseInProgress():
              return loading();
            case GetCourseFailure():
              return failure(state.message);
            case GetCourseSuccess():
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    buildCourse(state),
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget buildCourse(GetCourseSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ភាសាអង់គ្លេស',
          style: labelStyle.copyWith(fontSize: 14.sp),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => CustomCard(
              imageUrl: state.courses[index].imageUrl,
              onTap: () {
                AppNavigator.push(
                  CourseDetailPage(course: state.courses[index]),
                );
              },
            ),
            separatorBuilder: (_, i) => const SizedBox(
              width: 12,
            ),
            itemCount: state.courses.length,
          ),
        ),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'មេរៀន',
        style: labelStyle.copyWith(
          color: Theme.of(context).primaryColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget failure(String message) {
    return Center(
      child: Text(
        message,
        style: labelStyle.copyWith(fontSize: 14.sp),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
