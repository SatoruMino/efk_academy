part of '../course_detail_pages.dart';

class CourseReviewTabView extends StatelessWidget {
  const CourseReviewTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReviewCubit, GetReviewState>(
      builder: (context, state) {
        if (state.status == GetReviewStatus.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == GetReviewStatus.failure) {
          return Center(
            child: Text('try_again_later').tr(),
          );
        }

        if (state.status == GetReviewStatus.success) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemBuilder: (_, index) {
              final review = state.reviews[index];

              return ReviewCard(
                review: review,
              );
            },
            separatorBuilder: (_, i) => const SizedBox(
              height: 8,
            ),
            itemCount: state.reviews.length,
          );
        }

        return const SizedBox();
      },
    );
  }
}
