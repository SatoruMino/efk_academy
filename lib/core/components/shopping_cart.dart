import 'package:efk_academy/common/cart_cubit/cart_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CartCubit>().state.carts.length;
    return IconButton(
      onPressed: () {
        NavigatorHelper.push('');
      },
      icon: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -15, end: -5),
        badgeContent: Text(
          count.toString(),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
        ),
      ),
    );
  }
}
