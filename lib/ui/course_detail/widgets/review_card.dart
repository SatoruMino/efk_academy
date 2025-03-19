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
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.username,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                review.message,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        Text(
          review.createdDate,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
