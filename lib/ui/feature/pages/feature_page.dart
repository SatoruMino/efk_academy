import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              NavigatorHelper.push(AppRoute.news);
            },
            icon: Icon(
              color: Theme.of(context).primaryColor,
              Iconsax.notification_1_bold,
            ),
          ),
        ],
        title: Row(
          children: [
            Image.asset(
              height: 50.h,
              'assets/images/efk.png',
            ),
            const SizedBox(width: 8),
            Text(
              'EFK\nACADEMY',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Ubuntu',
              ),
            ),
          ],
        ),
        titleSpacing: 12,
      ),
      body: BlocBuilder<FeatureCubit, FeatureState>(
        builder: (context, state) {
          switch (state) {
            case FeatureInProgress():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FeatureFailure():
              return Center(
                child: Text(state.message),
              );
            case FeatureSuccess():
              return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Poster(state),
                    const SizedBox(height: 14),
                    Promotion(state),
                    const SizedBox(height: 14),
                    TrendingCourse(state),
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
}

class Poster extends StatelessWidget {
  const Poster(this.state, {super.key});

  final FeatureSuccess state;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CardSwiper(
        padding: EdgeInsets.zero,
        backCardOffset: const Offset(0, 18),
        cardBuilder: (_, index, x, y) => CustomCard(
          imageUrl: state.posters[index].imageUrl,
        ),
        cardsCount: state.posters.length,
      ),
    );
  }
}

class Promotion extends StatelessWidget {
  const Promotion(this.state, {super.key});

  final FeatureSuccess state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.tr('latest_promotions'),
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => CustomCard(
              imageUrl: state.promotions[index].imageUrl,
              onTap: () => {},
            ),
            separatorBuilder: (_, index) => const SizedBox(width: 12),
            itemCount: state.promotions.length,
          ),
        )
      ],
    );
  }
}

class TrendingCourse extends StatelessWidget {
  const TrendingCourse(this.state, {super.key});

  final FeatureSuccess state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.tr('trending_courses'),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => CustomCard(
              imageUrl: state.courses[index].imageUrl,
            ),
            separatorBuilder: (_, index) => const SizedBox(width: 12),
            itemCount: state.courses.length,
          ),
        )
      ],
    );
  }
}
