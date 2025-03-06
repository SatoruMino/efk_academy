part of '../pages/account_page.dart';

class SettingContainer extends StatelessWidget {
  const SettingContainer({
    super.key,
    required this.text,
    required this.tiles,
  });

  final String text;
  final List<SettingTile> tiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: labelStyle.copyWith(
            fontSize: 14.sp,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final tile = tiles[index];

              return SettingTile(
                icon: tile.icon,
                text: tile.text,
                onTap: tile.onTap,
              );
            },
            separatorBuilder: (_, i) => const Divider(
              height: 0.0,
            ),
            itemCount: tiles.length,
          ),
        ),
      ],
    );
  }
}
