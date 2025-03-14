class Course {
  const Course({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.summary,
    required this.description,
    required this.previewVideoId,
    required this.imageUrl,
    required this.sections,
  });

  final String id;
  final String name;
  final double price;
  final double discount;
  final String summary;
  final String description;
  final String previewVideoId;
  final String imageUrl;
  final List<Map<String, dynamic>> sections;
}
