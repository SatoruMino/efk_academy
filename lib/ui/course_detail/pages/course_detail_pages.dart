import 'package:flutter/material.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetailPages extends StatefulWidget {
  const CourseDetailPages({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  State<CourseDetailPages> createState() => _CourseDetailPagesState();
}

class _CourseDetailPagesState extends State<CourseDetailPages> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.course.previewVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        useHybridComposition: false,
      ),
    )..initialVideoId;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (_, player) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.close_outlined,
              ),
            ),
            centerTitle: true,
            title: Text(
              widget.course.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPlayer(player),
                const SizedBox(height: 12),
                buildAdditionalInfo(),
                const SizedBox(height: 12),
                buildPrice(),
                const SizedBox(height: 12),
                buildSummary(),
                const SizedBox(height: 12),
                buildDescription(),
                const SizedBox(height: 12),
                buildInstructor(),
                const SizedBox(height: 12),
                buildSections(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPlayer(Widget player) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: player,
    );
  }

  Widget buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${'additional_information'.tr()}៖',
          style: TextTheme.of(context).labelLarge,
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'created_at'.tr()}: ${widget.course.getDate}',
                style: TextTheme.of(context).labelMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '${'students'.tr()}: 0',
                style: TextTheme.of(context).labelMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '${'sections'.tr()}: 0',
                style: TextTheme.of(context).labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPrice() {
    final originalPrice = widget.course.price;
    if (widget.course.discount > 0) {
      return Row(
        children: [
          Text(
            '${'price'.tr()}:',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(width: 8),
          Text(
            '\$${originalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14.sp,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '\$${widget.course.getPrice.toStringAsFixed(2)}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Text(
      '\$${originalPrice.toStringAsFixed(2)}',
    );
  }

  Widget buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'summary'.tr(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          widget.course.summary,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'benefits_of_enrollment_on_this_course'.tr(),
          style: TextTheme.of(context).labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          widget.course.description,
          style: TextTheme.of(context).labelMedium,
        ),
      ],
    );
  }

  Widget buildInstructor() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.25),
            offset: const Offset(0, 0),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'instructor'.tr(),
            style: TextTheme.of(context).labelLarge,
          ),
          const SizedBox(height: 8),
          // .. instructor info
          Row(
            children: [
              Image.asset(
                height: 125.h,
                'assets/images/avatar_placeholder.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'name'.tr()}: ${widget.course.instructor.name}',
                    style: TextTheme.of(context).labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${'title'.tr()}: ${widget.course.instructor.title}',
                    style: TextTheme.of(context).labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${'likes'.tr()}: ${widget.course.instructor.name}',
                    style: TextTheme.of(context).labelMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // .. instructor bio
          ExpandableText(
            widget.course.instructor.bio,
            style: TextTheme.of(context).labelMedium,
            collapseText: 'show_less'.tr(),
            expandText: 'show_more'.tr(),
            linkStyle: TextTheme.of(context)
                .labelMedium
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget buildSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'videos'.tr(),
          style: TextTheme.of(context).labelLarge,
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
