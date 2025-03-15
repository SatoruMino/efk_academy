import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/ui/account/pages/account_page.dart';
import 'package:efk_academy/ui/course/pages/coures_page.dart';
import 'package:efk_academy/ui/feature/pages/feature_page.dart';
import 'package:efk_academy/ui/owned/pages/owned_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

part '../widgets/bottom_navigation_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final pages = [
    FeaturePage(),
    CouresPage(),
    OwnedPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: pages,
            ),
          ),
          BottomNavigationTabBar(
            controller: _controller,
            items: [
              NavBarItem(
                iconData: Iconsax.home_2_bold,
                text: context.tr('feature'),
              ),
              NavBarItem(
                iconData: Iconsax.youtube_bold,
                text: context.tr('course'),
              ),
              NavBarItem(
                iconData: Iconsax.category_bold,
                text: context.tr('owned'),
              ),
              NavBarItem(
                iconData: Iconsax.user_bold,
                text: context.tr('account'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
