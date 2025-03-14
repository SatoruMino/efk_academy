import 'package:efk_academy/domain/entities/new.dart';
import 'package:efk_academy/domain/usecases/auth/change_username.dart';
import 'package:efk_academy/domain/usecases/new/get_new.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/change_language/pages/change_language_page.dart';
import 'package:efk_academy/ui/change_username/cubits/change_username_cubit.dart';
import 'package:efk_academy/ui/change_username/pages/change_username_page.dart';
import 'package:efk_academy/ui/new/cubit/get_new_cubit.dart';
import 'package:efk_academy/ui/new/pages/new_page.dart';
import 'package:efk_academy/ui/new_detail/pages/new_detail_page.dart';
import 'package:efk_academy/ui/sign_in/pages/sign_in_page.dart';
import 'package:efk_academy/ui/sign_up/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static const String addReview = '/add_review';
  static const String courseDetail = '/course_detail';
  static const String changeTheme = '/change_theme';
  static const String changeLanguage = '/change_language';
  static const String changeUsername = '/change_username';
  static const String news = '/news';
  static const String newDetail = '/new_detail';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';

  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case changeLanguage:
        return MaterialPageRoute(builder: (_) => ChangeLanguagePage());
      case changeUsername:
        final currentUsername = setting.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ChangeUsernameCubit(
              changeUsername: sl<ChangeUsername>(),
              currentUsername: currentUsername,
            ),
            child: ChangeUsernamePage(
              username: currentUsername,
            ),
          ),
        );
      case news:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => GetNewCubit(getNew: sl<GetNew>())..getNews(),
            child: const NewPage(),
          ),
        );
      case newDetail:
        final item = setting.arguments as New;
        return MaterialPageRoute(
          builder: (_) => NewDetailPage(item),
        );
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('no-route-found'),
            ),
          ),
        );
    }
  }
}
