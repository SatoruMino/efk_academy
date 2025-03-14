part of '../course_detail_pages.dart';

class ReviewTabView extends StatelessWidget {
  const ReviewTabView({
    super.key,
    required this.user,
    required this.courseId,
  });

  final User? user;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetReviewCubit, GetReviewState>(
        builder: (context, state) {
          if (state is GetReviewInProgress) {
            return loading();
          }

          if (state is GetReviewFailure) {
            return failure(state.message);
          }

          if (state is GetReviewSuccess) {
            final reviews = state.reviews;

            if (reviews.isEmpty) {
              return Center(
                child: Text(
                  'មិនទាន់មានមិតិនៅឡើយទេ...!',
                  style: labelStyle.copyWith(fontSize: 14.sp),
                ),
              );
            } else {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (_, index) => ReviewCard(
                  review: state.reviews[index],
                ),
                separatorBuilder: (_, i) => const SizedBox(height: 8.0),
                itemCount: state.reviews.length,
              );
            }
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: floatingActionButton(context, user),
    );
  }

  Widget floatingActionButton(BuildContext context, User? user) {
    if (user == null) {
      return const SizedBox();
    }

    return FloatingActionButton(
      onPressed: () {
        NavigatorHelper.push(AppRoute.addReview);
      },
      child: const Icon(MingCute.chat_1_fill),
    );
  }

  Center failure(String message) {
    return Center(
      child: Text(
        message,
        style: labelStyle.copyWith(fontSize: 14.sp),
      ),
    );
  }

  Center loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
