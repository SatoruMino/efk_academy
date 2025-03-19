import 'package:efk_academy/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required GetCart getCart,
  })  : _getCart = getCart,
        super(const CartState());

  final GetCart _getCart;

  Future<void> getCarts() async {
    emit(state.copyWith(
      status: CartStatus.inProgress,
    ));

    final res = await _getCart(NoParam());

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: CartStatus.failure,
        ),
      ),
      (carts) => emit(
        state.copyWith(
          carts: carts,
          status: CartStatus.success,
        ),
      ),
    );
  }
}
