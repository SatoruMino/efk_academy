import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ReviewRemoteDataSource {
  Stream<List<ReviewModel>> getReview(String id);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final SupabaseClient supabaseClient;

  const ReviewRemoteDataSourceImpl(this.supabaseClient);

  @override
  Stream<List<ReviewModel>> getReview(String id) {
    return supabaseClient
        .from('reviews')
        .select('*, profiles(username)')
        .eq('course_id', id)
        .asStream()
        .map((data) {
      return data
          .map((reviewJson) => ReviewModel.fromJson(reviewJson))
          .toList();
    });
  }
}
