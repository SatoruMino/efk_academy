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
      final response =
          await supabaseClient.from('courses').select().order('id');

      return response
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getTrendingCourse() async {
    try {
      final response = await supabaseClient
          .from('courses')
          .select()
          .order('total_user', ascending: false);

      return response
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
