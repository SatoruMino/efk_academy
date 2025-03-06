import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/new_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class NewRemoteDataSource {
  Future<List<NewModel>> getNew();
}

class NewRemoteDataSourceImpl implements NewRemoteDataSource {
  final SupabaseClient supabaseClient;

  NewRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<NewModel>> getNew() async {
    try {
      final response = await supabaseClient
          .from('news')
          .select()
          .order('created_at', ascending: false);

      return response.map((newJson) => NewModel.fromJson(newJson)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
