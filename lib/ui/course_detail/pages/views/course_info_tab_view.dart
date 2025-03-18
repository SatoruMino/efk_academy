part of '../course_detail_pages.dart';

class CourseInfoTabView extends StatelessWidget {
  const CourseInfoTabView(this.course, {super.key});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // .. title
          Text(
            course.name,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w600,
            ),
          ),

          // .. summary
          Text(
            course.summary,
            style: Theme.of(context).textTheme.labelMedium,
          ),

          const SizedBox(height: 12),
          // .. additional infomation
          Text(
            'additional_information'.tr(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ${'students'.tr()}: 0',
                ),
                const SizedBox(height: 4),
                Text(
                  '- ${'sections'.tr()}: ${course.getSectionCount}',
                ),
                const SizedBox(height: 4),
                Text(
                  '- ${'lessons'.tr()}: ${course.getLessonCount}',
                ),
                const SizedBox(height: 4),
                Text(
                  '- ${'videos'.tr()}: ${course.getVideoCount}',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          // .. benefits of enrollment
          Text(
            'benefits_of_enrollment_on_this_course'.tr(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(
            course.description,
            style: Theme.of(context).textTheme.labelMedium,
          ),

          const SizedBox(height: 12),
          // .. instructors
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  'instructor'.tr(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Row(
                  children: [
                    Image.asset(
                      height: 150.h,
                      'assets/images/avatar_placeholder.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${'name'.tr()}: ${course.instructor.name}'),
                        const SizedBox(height: 6),
                        Text('${'title'.tr()}: ${course.instructor.title}'),
                        const SizedBox(height: 6),
                        Text('${'likes'.tr()}: 0'),
                        const SizedBox(height: 6),
                        Text('${'students'.tr()}: 0'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ExpandableText(
                  course.instructor.bio,
                  style: Theme.of(context).textTheme.labelMedium,
                  collapseText: 'show_less'.tr(),
                  expandText: 'show_more'.tr(),
                  linkColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
