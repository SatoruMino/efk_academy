import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/account/pages/account_page.dart';
import 'package:efk_academy/ui/course/pages/coures_page.dart';
import 'package:efk_academy/ui/feature/pages/feature_page.dart';
import 'package:efk_academy/ui/user_course/pages/user_course_page.dart';
import 'package:efk_academy/ui/wish_list/pages/wish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

part '../widgets/bottom_navigation_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final pages = const [
    FeaturePage(),
    CouresPage(),
    WishListPage(),
    UserCoursePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: TabBarView(
          children: pages
              .map(
                (page) => CustomKeepAliveWrapper(page),
              )
              .toList(),
        ),
        bottomNavigationBar: TabNavigationBar(),
      ),
    );
  }
}

class TabNavigationBar extends StatelessWidget {
  const TabNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
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
