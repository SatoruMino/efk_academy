import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CartRemoteDataSource {
  Future<List<CourseModel>> getCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  const CartRemoteDataSourceImpl(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<List<CourseModel>> getCart() async {
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser == null) {
      throw const ServerException('user-not-foudn');
    }

    try {
      final response = await supabaseClient
          .from('carts')
          .select('''id, courses(*)''')
          .eq('user_id', currentUser.id)
          .order('id');
    } on PostgrestException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
