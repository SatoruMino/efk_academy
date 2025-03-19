import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
