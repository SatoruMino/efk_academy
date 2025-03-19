import 'package:efk_academy/domain/entities/cart.dart';

class CartModel extends Cart {
  const CartModel({
    required super.id,
    required super.name,
    required super.price,
    required super.discount,
  });

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] ?? '',
      name: '',
      price: 0,
      discount: 0,
    );
  }

  CartModel copyWith({
    String? id,
    String? name,
    double? price,
    double? discount,
  }) {
    return CartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      discount: discount ?? this.discount,
    );
  }
}
