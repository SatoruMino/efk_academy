import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:efk_academy/ui/course/cubits/get_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouresPage extends StatelessWidget {
  const CouresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr(
            'course',
          ),
        ),
      ),
      body: BlocBuilder<GetCourseCubit, GetCourseState>(
        builder: (context, state) {
          if (state is GetCourseInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetCourseFailure) {
            return Center(
              child: Text(
                context.tr('try_again_later'),
              ),
            );
          }

          if (state is GetCourseSuccess) {
            final englishCourses = state.courses
                .where((course) => course.category.contains('English'))
                .toList();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  buildItem(context, englishCourses),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, List<Course> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('english'),
          style: TextTheme.of(context).labelMedium,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => CustomCard(
              imageUrl: courses[index].imageUrl,
              onTap: () => NavigatorHelper.push(
                AppRoute.courseDetail,
                arguments: courses[index],
              ),
            ),
            itemCount: courses.length,
          ),
        ),
      ],
    );
  }
}
