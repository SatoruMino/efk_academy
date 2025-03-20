import 'package:efk_academy/common/cubits/get_new_cubit/get_new_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class NewsNotification extends StatelessWidget {
  const NewsNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorHelper.push(AppRoute.news),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -15, end: -5),
        badgeStyle: badges.BadgeStyle(
          badgeColor: Theme.of(context).primaryColor,
        ),
        badgeContent: Text(
          context.watch<GetNewCubit>().state.news.length.toString(),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        child: Icon(
          Iconsax.notification_1_outline,
        ),
      ),
    );
  }
}
