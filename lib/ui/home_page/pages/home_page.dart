import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/course/cubits/get_course_cubit.dart';
import 'package:efk_academy/ui/course/pages/coures_page.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:efk_academy/ui/feature/pages/feature_page.dart';
import 'package:efk_academy/ui/account/pages/account_page.dart';
import 'package:efk_academy/ui/user_course/pages/user_course_page.dart';
import 'package:efk_academy/ui/wish_list/pages/wish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

part '../widgets/bottom_navigation_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: body(),
        bottomNavigationBar: bottomNavigationBar(locale),
      ),
    );
  }

  Widget body() {
    final pages = [
      BlocProvider(
        create: (_) => sl<FeatureCubit>()..getFeature(),
        child: FeaturePage(),
      ),
      BlocProvider(
        create: (_) => sl<GetCourseCubit>()..getCourses(),
        child: CouresPage(),
      ),
      WishListPage(),
      UserCoursePage(),
      AccountPage(),
    ];
    return TabBarView(
      children: pages.map((page) => CustomKeepAliveWrapper(page)).toList(),
    );
  }

  Widget bottomNavigationBar(Locale locale) {
    return BottomNavigationBarWidget(
      tabs: [
        TabModel(
          icon: Iconsax.home_2_bold,
          text: tr('home_page.bottom_navigation_bar.feature'),
        ),
        TabModel(
          icon: Iconsax.youtube_bold,
          text: tr('home_page.bottom_navigation_bar.course'),
        ),
        TabModel(
          icon: Iconsax.heart_bold,
          text: tr('home_page.bottom_navigation_bar.wish_list'),
        ),
        TabModel(
          icon: Iconsax.category_bold,
          text: tr('home_page.bottom_navigation_bar.my_course'),
        ),
        TabModel(
          icon: Iconsax.user_bold,
          text: tr('home_page.bottom_navigation_bar.account'),
        ),
      ],
    );
  }
}
