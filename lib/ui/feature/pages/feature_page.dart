import 'dart:async';
import 'package:flutter/material.dart';
import 'package:efk_academy/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:efk_academy/common/widgets/shopping_cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:efk_academy/common/widgets/news_notification.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  final CardSwiperController _controller = CardSwiperController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        _controller.swipe(CardSwiperDirection.left);
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              height: 50.h,
              'assets/images/efk.png',
            ),
            const SizedBox(width: 8),
            Text(
              'EFK ACADEMY',
              style: Theme.of(context).textTheme.displayLarge,
            )
          ],
        ),
        actions: const [
          NewsNotification(),
          ShoppingCart(),
        ],
      ),
      body: BlocBuilder<FeatureCubit, FeatureState>(
        builder: (context, state) {
          if (state is FeatureInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FeatureFailure) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is FeatureSuccess) {
            return RefreshIndicator(
              onRefresh: () async => context.read<FeatureCubit>().getFeature(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    FeaturePoster(_controller, state),
                    const SizedBox(height: 14),
                    FeaturePromotion(state),
                    const SizedBox(height: 14),
                    FeatureTrendingCourse(state),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class FeaturePoster extends StatelessWidget {
  const FeaturePoster(
    this.controller,
    this.state, {
    super.key,
  });

  final CardSwiperController controller;
  final FeatureSuccess state;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CardSwiper(
        controller: controller,
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

class FeaturePromotion extends StatelessWidget {
  const FeaturePromotion(this.state, {super.key});

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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    insetPadding: const EdgeInsets.all(24),
                    child: CachedNetworkImage(
                      imageUrl: state.promotions[index].imageUrl,
                    ),
                  ),
                );
              },
            ),
            separatorBuilder: (_, index) => const SizedBox(width: 12),
            itemCount: state.promotions.length,
          ),
        )
      ],
    );
  }
}

class FeatureTrendingCourse extends StatelessWidget {
  const FeatureTrendingCourse(
    this.state, {
    super.key,
  });

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
              onTap: () => NavigatorHelper.push(
                AppRoute.courseDetail,
                arguments: state.courses[index],
              ),
            ),
            separatorBuilder: (_, index) => const SizedBox(width: 12),
            itemCount: state.courses.length,
          ),
        )
      ],
    );
  }
}
