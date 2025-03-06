part of '../pages/home_page.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.tabs,
  });

  final List<TabModel> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: labelStyle.copyWith(
        height: 2.0,
      ),
      unselectedLabelStyle: labelStyle.copyWith(
        fontSize: 0,
      ),
      dividerHeight: 0.0,
      tabs: tabs
          .map(
            (tab) => Tab(
              height: 75.h,
              icon: Icon(
                tab.icon,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  tab.text,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class TabModel {
  const TabModel({
    required this.icon,
    required this.text,
  });

  final IconData icon;

  final String text;
}
