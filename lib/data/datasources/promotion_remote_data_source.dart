import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/promotion_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class PromotionRemoteDataSource {
  Future<List<PromotionModel>> getPromotion();
}

class PromotionRemoteDataSourceImpl implements PromotionRemoteDataSource {
  final SupabaseClient supabaseClient;

  const PromotionRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<PromotionModel>> getPromotion() async {
    try {
      final response = await supabaseClient
          .from('promotions')
          .select()
          .order('created_at', ascending: false);

      return response
          .map((promotionJson) => PromotionModel.fromJson(promotionJson))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
