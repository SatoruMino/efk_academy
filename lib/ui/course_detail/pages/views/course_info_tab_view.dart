part of '../course_detail_pages.dart';

class CourseInfoTabView extends StatelessWidget {
  const CourseInfoTabView({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // .. title
          _title(context),

          // .. additional infomation
          _additional(context),

          // .. isEnrolled
          BlocBuilder<GetEnrollmentCubit, GetEnrollmentState>(
            builder: (context, state) {
              if (state.status == GetEnrollmentStatus.inProgress) {
                return CircularProgressIndicator();
              }

              if (state.status == GetEnrollmentStatus.success) {
                if (!state.isEnrolled) {
                  return Row(
                    children: [
                      BlocSelector<CartCubit, CartState, bool>(
                        selector: (state) => state.carts.any(
                          (cart) => cart.courseId.contains(course.id),
                        ),
                        builder: (context, isExisted) {
                          return Expanded(
                            child: CustomButton(
                              text: isExisted
                                  ? 'go_to_cart'.tr()
                                  : 'add_to_cart'.tr(),
                              style: CustomButtonStyle.secondary(context),
                              onTap: () {
                                if (isExisted) {
                                  NavigatorHelper.push(AppRoute.cart);
                                } else {
                                  context
                                      .read<CartCubit>()
                                      .addToCart(course.id);
                                }
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomButton(
                          text: 'purchase_now'.tr(),
                          style: CustomButtonStyle.primary(context),
                          onTap: () {},
                        ),
                      ),
                    ],
                  );
                }
              }

              return const SizedBox();
            },
          ),

          // .. benefits of enrollment
          _benefits(context),

          // .. instructors
          _instructor(context),
        ],
      ),
    );
  }

  Container _instructor(BuildContext context) {
    return Container(
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
    );
  }

  Column _benefits(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'benefits_of_enrollment_on_this_course'.tr(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          course.description,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Column _additional(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                '- ${'sections'.tr()}: ${course.totalSection}',
              ),
              const SizedBox(height: 4),
              Text(
                '- ${'lessons'.tr()}: ${course.totalLesson}',
              ),
              const SizedBox(height: 4),
              Text(
                '- ${'videos'.tr()}: ${course.totalVideo}',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
