import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/course_detail/pages/course_detail_pages.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:efk_academy/ui/new/pages/new_page.dart';
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
      appBar: const _AppBar(),
      body: BlocConsumer<FeatureCubit, FeatureState>(
        listener: (context, state) {
          if (state is FeatureFailure) {
            AppToast.error(state.message);
          }
        },
        builder: (context, state) {
          switch (state) {
            case FeatureInProgress():
              return const _Loading();
            case FeatureFailure():
              return _Failure(state.message);
            case FeatureSuccess():
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    _Poster(state),
                    const SizedBox(height: 12.0),
                    _Promotion(state),
                    const SizedBox(height: 12.0),
                    _PopularCourse(state),
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

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            height: 50.h,
            'assets/images/efk.png',
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            'EFK ACADEMY',
            style: TextStyle(
              color: color,
              fontFamily: 'Ubuntu',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => AppNavigator.push(const NewPage()),
          icon: Icon(
            color: color,
            Iconsax.notification_1_bold,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'សូមធ្វើការព្យាយាមម្តងទៀតនៅពេលក្រោយ!',
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster(this.state);

  final FeatureSuccess state;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CardSwiper(
        padding: EdgeInsets.zero,
        backCardOffset: const Offset(0, 16),
        cardBuilder: (context, index, x, y) => CustomCard(
          imageUrl: state.posters[index].imageUrl,
        ),
        cardsCount: state.posters.length,
      ),
    );
  }
}

class _Promotion extends StatelessWidget {
  const _Promotion(this.state);

  final FeatureSuccess state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'ប្រូម៉ូសិនពិសេសៗ',
          style: labelStyle.copyWith(fontSize: 14.sp),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CustomCard(
                imageUrl: state.promotions[index].imageUrl,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 12,
            ),
            itemCount: state.posters.length,
          ),
        ),
      ],
    );
  }
}

class _PopularCourse extends StatelessWidget {
  const _PopularCourse(this.state);

  final FeatureSuccess state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'មេរៀនដែលពេញនិយមសិក្សា',
          style: labelStyle.copyWith(fontSize: 14.sp),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CustomCard(
              imageUrl: state.courses[index].imageUrl,
              onTap: () => AppNavigator.push(
                CourseDetailPage(
                  course: state.courses[index],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 12,
            ),
            itemCount: state.courses.length,
          ),
        ),
      ],
    );
  }
}
