import 'package:efk_academy/core/core.dart';
import 'package:flutter/material.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:efk_academy/common/cubits/cart_cubit/cart_cubit.dart';

part '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'carts'.tr(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.status == CartStatus.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == CartStatus.failure) {
            return Center(
              child: Text('try_again_later').tr(),
            );
          }

          if (state.status == CartStatus.success) {
            if (state.carts.isEmpty) {
              return Center(
                child: Text(
                  'no_items_yet'.tr(),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (_, index) {
                  final cart = state.carts[index];

                  return CartItem(
                    cart: cart,
                    onRemove: (value) {
                      context.read<CartCubit>().removeFromCart(value);
                    },
                  );
                },
                itemCount: state.carts.length,
              );
            }
          }

          return const Center();
        },
      ),
    );
  }
}
