part of '../pages/account_page.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        minTileHeight: 45.h,
        leading: Icon(icon),
        title: Text(
          text,
          style: labelStyle.copyWith(fontSize: 14.sp),
        ),
        trailing: Icon(Icons.arrow_right),
        onTap: onTap,
      ),
    );
  }
}
