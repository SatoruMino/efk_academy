import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
  });

  final String id;
  final String name;
  final double price;
  final double discount;

  @override
  List<Object?> get props => [id, name, price, discount];
}
