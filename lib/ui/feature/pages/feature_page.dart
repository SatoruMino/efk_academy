import 'dart:async';

import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/course_detail/pages/course_detail_pages.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:efk_academy/ui/new/pages/new_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  final _swipeController = CardSwiperController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _swipeController.swipe(CardSwiperDirection.left),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: appBar(color),
      body: BlocBuilder<FeatureCubit, FeatureState>(
        builder: (context, state) {
          switch (state) {
            case FeatureInProgress():
              return loading();
            case FeatureFailure():
              return failure(state.message);
            case FeatureSuccess():
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    posters(state),
                    const SizedBox(height: 16.0),
                    promotions(state),
                    const SizedBox(height: 12.0),
                    popularCourses(state),
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  AppBar appBar(Color color) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            height: 45.h,
            'assets/images/efk.png',
          ),
          const SizedBox(width: 8.0),
          Text(
            'EFK ACADEMY',
            style: TextStyle(
              color: color,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            AppNavigator.push(const NewPage());
          },
          icon: Icon(
            color: color,
            Iconsax.notification_1_bold,
          ),
        ),
      ],
    );
  }

  Widget failure(String message) {
    return Center(
      child: Text(
        message,
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget posters(FeatureSuccess state) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CardSwiper(
        controller: _swipeController,
        padding: EdgeInsets.zero,
        backCardOffset: const Offset(0, 18),
        cardBuilder: (_, index, x, y) => CustomCard(
          imageUrl: state.posters[index].imageUrl,
        ),
        cardsCount: state.posters.length,
      ),
    );
  }

  Widget promotions(FeatureSuccess state) {
    return Column(
      children: [
        Text(
          'ប្រូម៉ូសិនពិសេសៗ',
          style: labelStyle.copyWith(
            fontSize: 14.sp,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return CustomCard(
                imageUrl: state.promotions[index].imageUrl,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(24),
                      child: CustomCard(
                        imageUrl: state.promotions[index].imageUrl,
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (_, i) => const SizedBox(
              width: 12.0,
            ),
            itemCount: state.promotions.length,
          ),
        ),
      ],
    );
  }

  Widget popularCourses(FeatureSuccess state) {
    return Column(
      children: [
        Text(
          'មេរៀនពេញនិយមសិក្សា',
          style: labelStyle.copyWith(fontSize: 14.sp),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => CustomCard(
              imageUrl: state.courses[index].imageUrl,
              onTap: () {
                AppNavigator.push(
                  CourseDetailPage(course: state.courses[index]),
                );
              },
            ),
            separatorBuilder: (_, i) => SizedBox(
              width: 12.0,
            ),
            itemCount: state.courses.length,
          ),
        )
      ],
    );
  }
}
