import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/cart_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CartRemoteDataSource {
  Future<List<CartModel>> getCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  const CartRemoteDataSourceImpl(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<List<CartModel>> getCart() async {
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser == null) {
      throw const ServerException('user-not-foudn');
    }

    try {
      final response = await supabaseClient
          .from('carts')
          .select('id, courses(name, price, discount)')
          .eq('user_id', currentUser.id)
          .order('id');

      final cartModels = response.map((cartJson) {
        final courseJson = cartJson['courses'];
        return CartModel.fromJson(cartJson).copyWith(
          name: courseJson['name'],
          price: (courseJson['price'] as num).toDouble(),
          discount: (courseJson['discount'] as num).toDouble(),
        );
      }).toList();

      return cartModels;
    } on PostgrestException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
