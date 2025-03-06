import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/ui/change_language/pages/change_language_page.dart';
import 'package:efk_academy/ui/change_password/pages/change_password_page.dart';
import 'package:efk_academy/ui/change_theme/pages/change_theme_page.dart';
import 'package:efk_academy/ui/sign_out/pages/sign_out_page.dart';
import 'package:efk_academy/ui/change_username/pages/change_username_page.dart';
import 'package:efk_academy/ui/sign_in/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

part '../widgets/setting_tile.dart';
part '../widgets/setting_container.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserCubit cubit) => cubit.state.user);
    return Scaffold(
      appBar: appBar(user, context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            if (user != null) userAndSecurity(context) else login(context),
            system(context),
            helpAndSupport(),
          ],
        ),
      ),
    );
  }

  Widget helpAndSupport() {
    return SettingContainer(
      text: tr('account_page.help_and_support.title'),
      tiles: [
        SettingTile(
          icon: Iconsax.info_circle_outline,
          text: tr('account_page.help_and_support.about_us'),
          onTap: () {},
        ),
        SettingTile(
          icon: Iconsax.message_question_outline,
          text: tr('account_page.help_and_support.frequently_asked_questions'),
          onTap: () {},
        ),
        SettingTile(
          icon: MingCute.share_2_line,
          text: tr('account_page.help_and_support.share'),
          onTap: () {},
        ),
      ],
    );
  }

  Widget system(BuildContext context) {
    return SettingContainer(
      text: tr('account_page.app.title'),
      tiles: [
        SettingTile(
          icon: Iconsax.language_circle_outline,
          text: tr('account_page.app.languages.title'),
          onTap: () {
            AppNavigator.push(const ChangeLanguagePage());
          },
        ),
        SettingTile(
          icon: Iconsax.colorfilter_outline,
          text: tr('account_page.app.palettes.title'),
          onTap: () {
            AppNavigator.push(const ChangeThemePage());
          },
        ),
      ],
    );
  }

  Widget login(BuildContext context) {
    return SettingContainer(
      text: tr('account_page.user_and_security.title'),
      tiles: [
        SettingTile(
          icon: Iconsax.login_outline,
          text: tr('account_page.user_and_security.login'),
          onTap: () {
            AppNavigator.push(const SignInPage());
          },
        ),
      ],
    );
  }

  Widget userAndSecurity(BuildContext context) {
    return SettingContainer(
      text: 'ព័ត៌មាន និងឯកជនភាពគណនី',
      tiles: [
        SettingTile(
          icon: Iconsax.card_outline,
          text: 'ឈ្មោះប្រើប្រាស់',
          onTap: () {
            AppNavigator.push(const ChangeUsernamePage());
          },
        ),
        SettingTile(
          icon: Iconsax.security_safe_outline,
          text: 'ពាក្យសម្ងាត់',
          onTap: () {
            AppNavigator.push(const ChangePasswordPage());
          },
        ),
        SettingTile(
          icon: Iconsax.logout_outline,
          text: 'ចាកចេញ',
          onTap: () {
            AppNavigator.push(const SignOutPage());
          },
        ),
      ],
    );
  }

  AppBar appBar(User? user, BuildContext context) {
    return AppBar(
      title: Text(
        user == null
            ? tr('account_page.title')
            : '${tr('account_page.hello')}! ${user.username}',
        style: labelStyle.copyWith(
          color: Theme.of(context).primaryColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
