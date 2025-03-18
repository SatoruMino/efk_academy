import 'package:efk_academy/core/widgets/custom_expansion_list_tile.dart';
import 'package:efk_academy/ui/course_detail/cubit/get_enrollment_cubit/get_enrollment_cubit.dart';
import 'package:efk_academy/ui/course_detail/cubit/get_review_cubit/get_review_cubit.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'views/course_info_tab_view.dart';
part 'views/course_video_tab_view.dart';
part 'views/course_review_tab_view.dart';

part '../widgets/review_card.dart';

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
    final videoId = widget.course.previewVideoId;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        showLiveFullscreenButton: false,
        useHybridComposition: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.close_outlined,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              buildPlayer(),
              const SizedBox(height: 8),
              buildTabBar(),
              const SizedBox(height: 8),
              buildTabBarView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: YoutubePlayer(
        controller: _controller,
        bottomActions: [],
      ),
    );
  }

  Widget buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.75,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        labelPadding: EdgeInsets.zero,
        labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
        tabs: [
          Tab(
            text: 'info'.tr(),
          ),
          Tab(
            text: 'videos'.tr(),
          ),
          Tab(
            text: 'reviews'.tr(),
          ),
        ],
      ),
    );
  }

  Widget buildTabBarView() {
    return Expanded(
      child: TabBarView(
        children: [
          CourseInfoTabView(
            course: widget.course,
          ),
          CourseVideoTabView(
            sections: widget.course.sections,
            isEnrolled: context.read<GetEnrollmentCubit>().state,
          ),
          const CourseReviewTabView(),
        ],
      ),
    );
  }
}
