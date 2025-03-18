part of '../course_detail_pages.dart';

class CourseReviewTabView extends StatelessWidget {
  const CourseReviewTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReviewCubit, GetReviewState>(
      builder: (context, state) {
        switch (state.status) {
          case GetReviewStatus.inProgress:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case GetReviewStatus.failure:
            return Center(
              child: Text(
                'try_again'.tr(),
              ),
            );
          case GetReviewStatus.success:
            return ListView.builder(
              itemBuilder: (_, index) => ReviewCard(
                review: state.reviews[index],
              ),
              itemCount: state.reviews.length,
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
