part of '../course_detail_pages.dart';

class InfoTabView extends StatelessWidget {
  const InfoTabView({
    super.key,
    required this.course,
  });

  final Course course;

  double get _price => findPrice(course.price, course.discount);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pricing(theme),
            const SizedBox(height: 12.0),
            summarizing(),
            const SizedBox(height: 12.0),
            descriptioning(),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton(),
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      shape: const CircleBorder(),
      child: const Icon(
        MingCute.shopping_cart_2_fill,
      ),
    );
  }

  Widget descriptioning() {
    return Column(
      children: [
        Text(
          'អត្ថប្រយោជន៍ដែលអ្នកនឹងទទួលបានពីវគ្គសិក្សាមួយនេះ៖',
          style: labelStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          course.description,
          style: descriptionStyle,
        ),
      ],
    );
  }

  Widget summarizing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ខ្លឹមសារសង្ខេបនៃវគ្គសិក្សាមួយនេះ៖',
          style: labelStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          course.summary,
          style: descriptionStyle,
        ),
      ],
    );
  }

  Widget pricing(ThemeData theme) {
    bool isDiscount = course.discount != 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'តម្លៃនៃវគ្គសិក្សា៖',
          style: labelStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '${course.price.toStringAsFixed(2)}\$',
          style: TextStyle(
            color:
                isDiscount ? theme.colorScheme.onSurface : theme.primaryColor,
            fontWeight: isDiscount ? FontWeight.normal : FontWeight.w600,
            decoration: isDiscount ? TextDecoration.lineThrough : null,
            decorationColor: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 4.0),
        if (isDiscount)
          Text(
            '${_price.toStringAsFixed(2)}\$',
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
