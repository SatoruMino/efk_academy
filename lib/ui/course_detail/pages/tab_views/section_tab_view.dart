part of '../course_detail_pages.dart';

class SectionTabView extends StatelessWidget {
  const SectionTabView({
    super.key,
    required this.isEnrolled,
    required this.sections,
  });

  final bool isEnrolled;
  final List<Map<String, dynamic>> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        scrollDirection: Axis.vertical,
        children: sections
            .map(
              (section) => AnimatedExpansionTile(
                leading: Text(
                  section['id'],
                  style: labelStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                title: Text(
                  section['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: (section['lessons'] as List)
                    .map(
                      (lesson) => AnimatedExpansionTile(
                        leading: Text(
                          lesson['id'],
                          style: labelStyle.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        title: Text(
                          lesson['title'],
                          style: labelStyle.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        children: (lesson['videos'] as List)
                            .map(
                              (video) => ListTile(
                                minVerticalPadding: 0.0,
                                minTileHeight: 50.0,
                                leading: Text(
                                  video['id'],
                                ),
                                title: Text(
                                  video['title'],
                                  style: descriptionStyle,
                                ),
                                trailing: Icon(
                                  size: 15.h,
                                  isEnrolled
                                      ? MingCute.play_fill
                                      : MingCute.lock_line,
                                ),
                                onTap: () {},
                              ),
                            )
                            .toList(),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
