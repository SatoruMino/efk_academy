import 'package:efk_academy/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required GetCart getCart,
    required AddToCart addToCart,
    required RemoveFromCart removeFromCart,
  })  : _getCart = getCart,
        _addToCart = addToCart,
        _removeFromCart = removeFromCart,
        super(const CartState());

  final GetCart _getCart;
  final AddToCart _addToCart;
  final RemoveFromCart _removeFromCart;

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

  Future<void> addToCart(String courseId) async {
    emit(state.copyWith(
      status: CartStatus.inProgress,
    ));

    final res = await _addToCart(courseId);

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: CartStatus.failure,
        ),
      ),
      (cart) {
        final updatedCarts = state.carts..add(cart);
        emit(
          state.copyWith(
            carts: updatedCarts,
            status: CartStatus.success,
          ),
        );
      },
    );
  }

  Future<void> removeFromCart(String id) async {
    emit(state.copyWith(status: CartStatus.inProgress));

    final res = await _removeFromCart(id);

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: CartStatus.failure,
        ),
      ),
      (cart) {
        final updatedCart = state.carts..remove(cart);
        emit(
          state.copyWith(
            carts: updatedCart,
            status: CartStatus.success,
          ),
        );
      },
    );
  }
}
