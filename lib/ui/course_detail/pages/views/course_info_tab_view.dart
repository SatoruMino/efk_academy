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
          CourseTitleInfo(
            title: course.name,
            summary: course.summary,
          ),

          // .. additional infomation
          CourseAdditionalInfo(
            totalStudent: 0,
            totalSection: course.totalSection,
            totalLesson: course.totalLesson,
            totalVideo: course.totalVideo,
          ),

          // .. add to cart, purchase
          CourseEnrollmentInfo(
            id: course.id,
            price: course.price,
            discount: course.discount,
          ),

          // .. benefits of enrollment
          CourseBenefitInfo(
            description: course.description,
          ),

          // .. instructors
          CourseInstructorInfo(
            instructor: course.instructor,
          ),
        ],
      ),
    );
  }
}

class CourseTitleInfo extends StatelessWidget {
  const CourseTitleInfo({
    super.key,
    required this.title,
    required this.summary,
  });

  final String title;
  final String summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.labelLarge,
        ),
        Text(
          summary,
          style: textTheme.labelMedium,
        ),
      ],
    );
  }
}

class CourseAdditionalInfo extends StatelessWidget {
  const CourseAdditionalInfo({
    super.key,
    required this.totalStudent,
    required this.totalSection,
    required this.totalLesson,
    required this.totalVideo,
  });

  final int totalStudent;
  final int totalSection;
  final int totalLesson;
  final int totalVideo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'additional_information'.tr(),
          style: textTheme.labelLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(
                textTheme,
                'students',
                '0',
              ),
              _buildText(
                textTheme,
                'sections',
                totalSection.toString(),
              ),
              _buildText(
                textTheme,
                'lessons',
                totalLesson.toString(),
              ),
              _buildText(
                textTheme,
                'videos',
                totalVideo.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildText(
    TextTheme textTheme,
    String label,
    String info,
  ) {
    return Text(
      '- ${label.tr()}: $info',
      style: textTheme.labelMedium,
    );
  }
}

class CourseBenefitInfo extends StatelessWidget {
  const CourseBenefitInfo({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'benefits_of_enrollment_on_this_course'.tr(),
          style: textTheme.labelLarge,
        ),
        Text(
          description,
          style: textTheme.labelMedium,
        ),
      ],
    );
  }
}

class CourseInstructorInfo extends StatelessWidget {
  const CourseInstructorInfo({
    super.key,
    required this.instructor,
  });

  final Instructor instructor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(
            'instructor'.tr(),
            style: textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                height: 150.h,
                Constant.avatarPlaceholder,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(
                    textTheme,
                    'name',
                    instructor.name,
                  ),
                  _buildText(
                    textTheme,
                    'title',
                    instructor.title,
                  ),
                  _buildText(
                    textTheme,
                    'likes',
                    '0',
                  ),
                  _buildText(
                    textTheme,
                    'students',
                    '0',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ExpandableText(
            instructor.bio,
            style: textTheme.labelMedium,
            collapseText: 'show_less'.tr(),
            expandText: 'show_more'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildText(
    TextTheme textTheme,
    String label,
    String info,
  ) {
    return Text(
      '${label.tr()}: $info',
      style: textTheme.labelMedium,
    );
  }
}

class CourseEnrollmentInfo extends StatelessWidget {
  const CourseEnrollmentInfo({
    super.key,
    required this.id,
    required this.price,
    required this.discount,
  });

  final String id;
  final double price;
  final double discount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExisted = context.select((CartCubit cubit) =>
        cubit.state.carts.any((cart) => cart.courseId.contains(id)));
    return BlocSelector<UserCubit, UserState, bool>(
      selector: (state) => state.status == UserStatus.authenticated,
      builder: (context, isLogin) {
        return BlocBuilder<GetEnrollmentCubit, GetEnrollmentState>(
          builder: (context, state) {
            if (state.status == GetEnrollmentStatus.inProgress) {
              return const CircularProgressIndicator();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPrice(theme),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildCartButton(
                      context,
                      isExisted,
                      isLogin,
                    ),
                    const SizedBox(width: 8),
                    _buildPurchaseButton(
                      context,
                      isLogin,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPrice(ThemeData theme) {
    if (discount > 0) {
      return Row(
        children: [
          Text(
            '\$${findPrice(price, discount).toStringAsFixed(2)}',
            style: theme.textTheme.displayLarge,
          ),
          const SizedBox(width: 8),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: theme.textTheme.labelMedium
                ?.copyWith(decoration: TextDecoration.lineThrough),
          ),
        ],
      );
    } else {
      return Text(
        '\$${price.toStringAsFixed(2)}',
        style: theme.textTheme.displayLarge,
      );
    }
  }

  Widget _buildCartButton(BuildContext context, bool isExisted, bool isLogin) {
    return Expanded(
      child: CustomButton(
        text: isExisted ? 'go_to_cart'.tr() : 'add_to_cart'.tr(),
        style: CustomButtonStyle.secondary(context),
        onTap: () {
          if (!isLogin) {
            NavigatorHelper.push(AppRoute.signIn);
          } else if (isExisted) {
            NavigatorHelper.push(AppRoute.cart);
          } else {
            context.read<CartCubit>().addToCart(id);
          }
        },
      ),
    );
  }

  Widget _buildPurchaseButton(BuildContext context, bool isLogin) {
    return Expanded(
      child: CustomButton(
        text: 'purchase_now'.tr(),
        style: CustomButtonStyle.primary(context),
        onTap: () {
          if (!isLogin) {
            NavigatorHelper.push(AppRoute.signIn);
            return;
          }
        },
      ),
    );
  }
}
