import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/cubits/cart_cubit/cart_cubit.dart';
import 'package:efk_academy/common/cubits/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocSelector<UserCubit, UserState, bool>(
      selector: (state) => state.status == UserStatus.authenticated,
      builder: (context, isAuthenticated) {
        if (isAuthenticated) {
          return IconButton(
            onPressed: () {
              NavigatorHelper.push(AppRoute.cart);
            },
            icon: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -15, end: -5),
              badgeContent: Text(
                context.watch<CartCubit>().state.carts.length.toString(),
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: theme.scaffoldBackgroundColor),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => NavigatorHelper.push(AppRoute.signIn),
            child: Text(
              'sign_in'.tr(),
              style: theme.textTheme.labelMedium,
            ),
          );
        }
      },
    );
  }
}
