part of '../pages/course_detail_pages.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          review.username,
        ),
        const SizedBox(height: 8),
        Text(
          review.message,
        ),
      ],
    );
  }
}
