import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/core/helpers/navigator.dart';
import 'package:efk_academy/domain/entities/course.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/course_detail/cubits/get_review_cubit/get_review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'tab_views/info_tab_view.dart';
part 'tab_views/review_tab_view.dart';
part 'tab_views/section_tab_view.dart';

part '../widgets/animated_expansion_tile.dart';
part '../widgets/review_card.dart';
part '../widgets/expandable_text.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();

    initializeVideo();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  initializeVideo() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.course.previewVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        useHybridComposition: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetReviewCubit>()..getReviews(widget.course.id),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubePlayerController,
        ),
        builder: (_, player) {
          return Scaffold(
            body: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  player,
                  tabBar(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget tabView(User? user) {
    return Expanded(
      child: TabBarView(
        children: [
          InfoTabView(
            course: widget.course,
          ),
          ReviewTabView(
            user: user,
            courseId: widget.course.id,
          ),
        ],
      ),
    );
  }

  Widget tabBar() {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border.all(
          color: theme.primaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor,
            offset: const Offset(0, 3.5),
          ),
        ],
      ),
      child: TabBar(
        dividerHeight: 0.0,
        splashFactory: NoSplash.splashFactory,
        tabs: [
          Tab(
            text: 'លម្អិត',
          ),
          Tab(
            text: 'វីដេអូ',
          ),
          Tab(
            text: 'មិតិយោបល់',
          ),
        ],
      ),
    );
  }

  AppBar appBar(User? user, String name) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.close_outlined,
        ),
      ),
      centerTitle: true,
      title: Text(
        name,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
