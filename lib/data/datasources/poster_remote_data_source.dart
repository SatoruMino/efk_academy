import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/poster_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class PosterRemoteDataSource {
  Future<List<PosterModel>> getPosters();
}

class PosterRemoteDataSourceImpl implements PosterRemoteDataSource {
  final SupabaseClient supabaseClient;

  const PosterRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<PosterModel>> getPosters() async {
    try {
      final response = await supabaseClient
          .from('posters')
          .select()
          .order('created_at', ascending: false);

      return response.map((poster) => PosterModel.fromJson(poster)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
