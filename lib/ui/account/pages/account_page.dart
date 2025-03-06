import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/sign_in/pages/sign_in_page.dart';
import 'package:efk_academy/ui/sign_out/pages/sign_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

part '../widgets/setting_container.dart';
part '../widgets/setting_tile.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('account_page.title'),
          style: labelStyle.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          children: [
            UserAndSecurity(),
            const SizedBox(height: 12.0),
            System(),
            const SizedBox(height: 12.0),
            HelpAndSupport(),
          ],
        ),
      ),
    );
  }
}

class UserAndSecurity extends StatelessWidget {
  const UserAndSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserCubit cubit) => cubit.state.user);
    if (user != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('account_page.user_and_security.title'),
            style: labelStyle.copyWith(
              fontSize: 14.sp,
            ),
          ),
          const SizedBox(height: 8.0),
          CustomListTile(
            iconData: Iconsax.card_bold,
            text: tr('account_page.user_and_security.username'),
            onTap: () {},
          ),
          CustomListTile(
            iconData: Iconsax.security_safe_bold,
            text: tr('account_page.user_and_security.password'),
            onTap: () {},
          ),
          CustomListTile(
            iconData: Iconsax.logout_bold,
            text: tr('account_page.user_and_security.logout'),
            onTap: () => AppNavigator.push(const SignOutPage()),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('account_page.user_and_security.title'),
            style: labelStyle.copyWith(fontSize: 14.sp),
          ),
          const SizedBox(height: 8.0),
          CustomListTile(
            iconData: Iconsax.login_bold,
            text: tr('account_page.user_and_security.login'),
            onTap: () => AppNavigator.push(const SignInPage()),
          ),
        ],
      );
    }
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
          tr('account_page.system.title'),
          style: labelStyle.copyWith(fontSize: 14.sp),
        ),
        const SizedBox(height: 8.0),
        CustomListTile(
          iconData: Iconsax.paintbucket_bold,
          text: tr('account_page.system.palettes.title'),
          onTap: () {},
        ),
        CustomListTile(
          iconData: Iconsax.language_circle_bold,
          text: tr('account_page.system.languages.title'),
          onTap: () {},
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
          tr('account_page.help_and_support.title'),
          style: labelStyle.copyWith(fontSize: 14.sp),
        ),
        CustomListTile(
          iconData: Iconsax.info_circle_bold,
          text: tr('account_page.help_and_support.about_us'),
          onTap: () {},
        ),
        CustomListTile(
          iconData: Iconsax.message_question_bold,
          text: tr('account_page.help_and_support.frequently_asked_questions'),
          onTap: () {},
        ),
        CustomListTile(
          iconData: Iconsax.send_1_bold,
          text: tr('account_page.help_and_support.share'),
          onTap: () {},
        ),
      ],
    );
  }
}
