part of 'cart_cubit.dart';

enum CartStatus { initial, inProgress, failure, success }

final class CartState extends Equatable {
  const CartState({
    this.carts = const [],
    this.errorMessage = '',
    this.status = CartStatus.initial,
  });

  final List<String> carts;
  final String errorMessage;
  final CartStatus status;

  @override
  List<Object?> get props => [carts, errorMessage, status];
}
