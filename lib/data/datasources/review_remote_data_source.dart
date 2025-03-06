import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/review_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ReviewRemoteDataSource {
  Future<List<ReviewModel>> getReview(String courseId);
  Future<ReviewModel> addReview(String courseId, String message);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final SupabaseClient supabaseClient;

  const ReviewRemoteDataSourceImpl(this.supabaseClient);

  Session? get _currentSession => supabaseClient.auth.currentSession;

  @override
  Future<List<ReviewModel>> getReview(String courseId) async {
    try {
      final response = await supabaseClient
          .rpc('get_review', params: {'p_course_id': courseId})
          .select()
          .order('created_at', ascending: false);

      return response
          .map((reviewJson) => ReviewModel.fromJson(reviewJson))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReviewModel> addReview(String courseId, String message) async {
    if (_currentSession == null) {
      throw const ServerException('user-not-found');
    }

    try {
      final response = await supabaseClient
          .from('reviews')
          .insert({
            'user_id': _currentSession!.user.id,
            'course_id': courseId,
            'message': message,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return ReviewModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
