import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CourseRemoteDataSource {
  Future<List<CourseModel>> getCourse();
  Future<List<CourseModel>> getTrendingCourse();
  Future<List<CourseModel>> searchCourseByCategory(String category);
  Future<List<CourseModel>> searchCourseByName(String name);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final SupabaseClient supabaseClient;

  const CourseRemoteDataSourceImpl(this.supabaseClient);

  Session? get _currentSession => supabaseClient.auth.currentSession;

  @override
  Future<List<CourseModel>> getCourse() async {
    try {
      final response = await supabaseClient
          .rpc('get_course_with_purchase_status', params: {
            'p_user_id': _currentSession?.user.id,
          })
          .select()
          .order('id');

      return response
          .map((couresJson) => CourseModel.fromJson(couresJson))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getTrendingCourse() async {
    try {
      final response = await supabaseClient
          .rpc('get_course_with_purchase_status', params: {
            'p_user_id': _currentSession?.user.id,
          })
          .select()
          .order('total_user', ascending: false);

      return response
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> searchCourseByCategory(String category) async {
    try {
      final response = await supabaseClient
          .rpc('get_course_with_purchase_status', params: {
            'p_user_id': _currentSession?.user.id,
          })
          .ilike('category', '%$category%')
          .select()
          .order('total_user', ascending: false);

      return response
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> searchCourseByName(String name) async {
    try {
      final response = await supabaseClient
          .rpc('get_course_with_purchase_status', params: {
            'p_user_id': _currentSession?.user.id,
          })
          .ilike('name', '%$name%')
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
