class Course {
  const Course({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.summary,
    required this.description,
    required this.instructorName,
    required this.instructorTitle,
    required this.instructorBio,
    required this.previewVideoId,
    required this.imageUrl,
    required this.sections,
    required this.isEnrolled,
  });

  final String id;
  final String name;
  final double price;
  final double discount;
  final String summary;
  final String description;
  final String instructorName;
  final String instructorTitle;
  final String instructorBio;
  final String previewVideoId;
  final String imageUrl;
  final List<Map<String, dynamic>> sections;
  final bool isEnrolled;
}
