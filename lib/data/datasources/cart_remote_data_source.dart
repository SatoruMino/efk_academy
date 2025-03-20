import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/cart_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CartRemoteDataSource {
  Future<List<CartModel>> getCart();
  Future<CartModel> addToCart(CartModel cartModel);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  const CartRemoteDataSourceImpl(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<List<CartModel>> getCart() async {
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser == null) {
      throw const ServerException('user-not-found');
    }

    try {
      final response = await supabaseClient
          .from('carts')
          .select('*, courses(name, price, discount, image_url)')
          .eq('user_id', currentUser.id)
          .order('id', ascending: false);

      final cartModels = response.map((cartJson) {
        return CartModel.fromJson(cartJson);
      }).toList();

      return cartModels;
    } on PostgrestException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CartModel> addToCart(CartModel cartModel) async {
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser == null) {
      throw const ServerException('user-not-found');
    }

    try {
      final response = await supabaseClient
          .from('carts')
          .insert(cartModel.copyWith(userId: currentUser.id).toJson())
          .select('*, courses(name,price,discount, image_url)')
          .single();

      return CartModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
