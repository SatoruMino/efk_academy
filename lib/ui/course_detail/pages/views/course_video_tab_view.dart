part of '../course_detail_pages.dart';

class CourseVideoTabView extends StatelessWidget {
  const CourseVideoTabView({
    super.key,
    required this.sections,
    required this.isEnrolled,
  });

  final List<Section> sections;
  final bool isEnrolled;

  @override
  Widget build(BuildContext context) {
    print(isEnrolled);
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemBuilder: (_, index) {
        final section = sections[index];

        return CustomExpansionListTile(
          leading: section.id,
          title: section.name,
          iconSize: 18.sp,
          style: Theme.of(context).textTheme.labelMedium,
          children: List.generate(
            section.lessons.length,
            (index) {
              final lesson = section.lessons[index];

              return CustomExpansionListTile(
                leading: lesson.id,
                title: lesson.name,
                iconSize: 16.sp,
                style: Theme.of(context).textTheme.labelSmall,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final video = lesson.videos[index];
                      return ListTile(
                        onTap: () {},
                        enabled: isEnrolled,
                        leading: Text(video.id),
                        title: Text(
                          video.name,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        trailing: Icon(
                          size: 16.sp,
                          isEnrolled ? MingCute.play_fill : MingCute.lock_fill,
                        ),
                      );
                    },
                    itemCount: lesson.videos.length,
                  ),
                ],
              );
            },
          ),
        );
      },
      itemCount: sections.length,
    );
  }
}
