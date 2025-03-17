import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CourseRemoteDataSource {
  Future<List<CourseModel>> getCourse();
  Future<List<CourseModel>> getTrendingCourse();
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final SupabaseClient supabaseClient;

  const CourseRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<CourseModel>> getCourse() async {
    try {
      final response = await supabaseClient
          .from('courses')
          .select('''*, instructors(*)''').order('created_at');

      final courseModels =
          response.map((courseJson) => CourseModel.fromJson(courseJson));

      return courseModels.toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getTrendingCourse() async {
    try {
      final response = await supabaseClient
          .from('courses')
          .select('''*, instructors(*)''')
          .filter('review_count', 'gte', 3)
          .filter('enrollment_count', 'gte', 50)
          .order('created_at', ascending: false)
          .limit(10);

      final courseModels =
          response.map((courseJson) => CourseModel.fromJson(courseJson));

      return courseModels.toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
