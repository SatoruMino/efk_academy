import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required GetCart getCart,
  })  : _getCart = getCart,
        super(const CartState());

  final GetCart _getCart;
}
