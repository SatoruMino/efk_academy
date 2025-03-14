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
        labelPadding: const EdgeInsets.all(12),
        tabs: items
            .map((item) => Tab(
                  child: FittedBox(
                    child: Column(
                      children: [
                        Icon(
                          item.iconData,
                        ),
                        const SizedBox(height: 8),
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
