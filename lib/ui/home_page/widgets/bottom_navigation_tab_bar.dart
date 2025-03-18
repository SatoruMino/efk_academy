part of '../pages/home_page.dart';

class BottomNavigationTabBar extends StatelessWidget {
  const BottomNavigationTabBar({
    super.key,
    required this.controller,
    required this.items,
  });

  final TabController controller;
  final List<NavBarItem> items;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        unselectedLabelStyle: const TextStyle(
          fontSize: 0,
        ),
        tabs: items
            .map((item) => Tab(
                  height: 50.h,
                  child: FittedBox(
                    child: Column(
                      children: [
                        Icon(
                          item.iconData,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.text,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList());
  }
}

class NavBarItem {
  const NavBarItem({
    required this.iconData,
    required this.text,
  });

  final IconData iconData;
  final String text;
}
