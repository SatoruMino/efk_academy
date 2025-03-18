import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ReviewRemoteDataSource {
  Future<List<ReviewModel>> getReview(String id);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final SupabaseClient supabaseClient;

  const ReviewRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<ReviewModel>> getReview(String id) async {
    try {
      final response = await supabaseClient
          .from('reviews')
          .select('''*, profiles(username)''')
          .eq('course_id', id)
          .order('created_at', ascending: false);

      final reviews =
          response.map((json) => ReviewModel.fromJson(json)).toList();

      return reviews;
    } on PostgrestException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
