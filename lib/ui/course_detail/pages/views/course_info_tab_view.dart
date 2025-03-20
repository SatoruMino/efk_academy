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
          title(context),

          // .. price
          price(),

          // .. additional infomation
          additional(context),

          // .. add to cart, purchase
          enrollment(),

          // .. benefits of enrollment
          benefits(context),

          // .. instructors
          instructor(context),
        ],
      ),
    );
  }

  Widget title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.name,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        // .. summary
        Text(
          course.summary,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget price() {
    return Text('');
  }

  Widget additional(BuildContext context) {
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
              _buildAdditionInfo(
                label: 'students',
                text: '0',
              ),
              const SizedBox(height: 4),
              _buildAdditionInfo(
                label: 'sections',
                text: course.totalSection.toString(),
              ),
              const SizedBox(height: 4),
              _buildAdditionInfo(
                label: 'lessons',
                text: course.totalLesson.toString(),
              ),
              const SizedBox(height: 4),
              _buildAdditionInfo(
                label: 'videos',
                text: course.totalVideo.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAdditionInfo({
    required String label,
    required String text,
  }) {
    return Text('- ${label.tr()}: $text');
  }

  Widget enrollment() {
    return BlocSelector<UserCubit, UserState, bool>(
      selector: (state) => state.status == UserStatus.authenticated,
      builder: (context, isLogin) {
        return BlocBuilder<GetEnrollmentCubit, GetEnrollmentState>(
          builder: (context, state) {
            if (state.status == GetEnrollmentStatus.inProgress) {
              return const CircularProgressIndicator();
            }

            if (state.status == GetEnrollmentStatus.success) {
              if (!state.isEnrolled) {
                return Row(
                  children: [
                    _buildCartButton(context, isLogin),
                    const SizedBox(width: 8),
                    _buildPurchaseButton(context, isLogin),
                  ],
                );
              }
            }

            return const SizedBox();
          },
        );
      },
    );
  }

  _buildCartButton(BuildContext context, bool isLogin) {
    return BlocSelector<CartCubit, CartState, bool>(
      selector: (state) => state.carts.any(
        (cart) => cart.courseId.contains(course.id),
      ),
      builder: (context, existed) {
        return Expanded(
          child: CustomButton(
            text: existed ? 'go_to_cart'.tr() : 'add_to_cart'.tr(),
            style: CustomButtonStyle.secondary(context),
            onTap: isLogin
                ? () {
                    if (existed) {
                      NavigatorHelper.push(AppRoute.cart);
                    } else {
                      context.read<CartCubit>().addToCart(course.id);
                    }
                  }
                : () {
                    NavigatorHelper.push(AppRoute.signIn);
                  },
          ),
        );
      },
    );
  }

  Widget benefits(BuildContext context) {
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

  _buildPurchaseButton(BuildContext context, bool isLogin) {
    return Expanded(
      child: CustomButton(
        text: 'purchase_now'.tr(),
        style: CustomButtonStyle.primary(context),
        onTap: () {},
      ),
    );
  }

  Widget instructor(BuildContext context) {
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
                  _buildInstructorInfo(
                    label: 'name',
                    text: course.instructor.name,
                  ),
                  const SizedBox(height: 6),
                  _buildInstructorInfo(
                    label: 'title',
                    text: course.instructor.title,
                  ),
                  const SizedBox(height: 6),
                  _buildInstructorInfo(
                    label: 'likes',
                    text: '0',
                  ),
                  const SizedBox(height: 6),
                  _buildInstructorInfo(
                    label: 'students',
                    text: '0',
                  ),
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

  _buildInstructorInfo({
    required String label,
    required String text,
  }) {
    return Text('${label.tr()}: $text');
  }
}
