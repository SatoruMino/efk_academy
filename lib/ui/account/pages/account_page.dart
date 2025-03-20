import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/cubits/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('account'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: Column(
          children: [
            Security(),
            const SizedBox(height: 4),
            System(),
            const SizedBox(height: 4),
            HelpAndSupport(),
          ],
        ),
      ),
    );
  }
}

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserCubit cubit) => cubit.state.user);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('user_and_security'.tr()),
        if (user != User.empty) ...[
          CustomListTile(
            iconData: Iconsax.card_bold,
            text: context.tr('username'),
            onTap: () => NavigatorHelper.push(
              AppRoute.changeUsername,
              arguments: user.username,
            ),
          ),
          CustomListTile(
            iconData: Iconsax.security_safe_bold,
            text: context.tr('password'),
            onTap: () => NavigatorHelper.push(AppRoute.changePassword),
          ),
          CustomListTile(
            iconData: Iconsax.logout_1_bold,
            text: context.tr('logout'),
            onTap: () => NavigatorHelper.push(AppRoute.signOut),
          ),
        ] else
          CustomListTile(
            iconData: Iconsax.login_1_bold,
            text: context.tr('sign_in'),
            onTap: () => NavigatorHelper.push(AppRoute.signIn),
          ),
      ],
    );
  }
}

class System extends StatelessWidget {
  const System({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'system'.tr(),
        ),
        CustomListTile(
          iconData: Iconsax.paintbucket_bold,
          text: context.tr('palettes'),
          onTap: () {},
        ),
        CustomListTile(
          iconData: Iconsax.language_circle_bold,
          text: context.tr('languages'),
          onTap: () {
            NavigatorHelper.push(AppRoute.changeLanguage);
          },
        ),
      ],
    );
  }
}

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('help_and_support'),
        ),
        CustomListTile(
          iconData: Iconsax.info_circle_bold,
          text: context.tr('about_us'),
          onTap: () {},
        ),
        CustomListTile(
          iconData: Iconsax.message_question_bold,
          text: context.tr('frequently_asked_questions'),
          onTap: () {},
        ),
        CustomListTile(
          iconData: Iconsax.send_1_bold,
          text: context.tr('share'),
          onTap: () {},
        ),
      ],
    );
  }
}
