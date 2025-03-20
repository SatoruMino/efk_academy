import 'package:efk_academy/common/ui/cart/page/cart_page.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/domain/usecases/auth/forget_password.dart';
import 'package:efk_academy/domain/usecases/enrollment/get_enrollment.dart';
import 'package:efk_academy/ui/change_language/pages/change_language_page.dart';
import 'package:efk_academy/ui/change_theme/page/change_theme_page.dart';
import 'package:efk_academy/ui/change_username/cubits/change_username_cubit.dart';
import 'package:efk_academy/ui/change_username/pages/change_username_page.dart';
import 'package:efk_academy/ui/course_detail/cubit/get_enrollment_cubit/get_enrollment_cubit.dart';
import 'package:efk_academy/ui/course_detail/cubit/get_review_cubit/get_review_cubit.dart';
import 'package:efk_academy/ui/course_detail/pages/course_detail_pages.dart';
import 'package:efk_academy/ui/forget_password/cubit/forget_password_cubit.dart';
import 'package:efk_academy/ui/forget_password/pages/forget_password_page.dart';
import 'package:efk_academy/ui/new/cubit/get_new_cubit.dart';
import 'package:efk_academy/ui/new/pages/new_page.dart';
import 'package:efk_academy/ui/new_detail/pages/new_detail_page.dart';
import 'package:efk_academy/ui/sign_in/cubits/sign_in_cubit.dart';
import 'package:efk_academy/ui/sign_in/pages/sign_in_page.dart';
import 'package:efk_academy/ui/sign_out/cubit/sign_out_cubit.dart';
import 'package:efk_academy/ui/sign_out/pages/sign_out_page.dart';
import 'package:efk_academy/ui/sign_up/cubits/sign_up_cubit.dart';
import 'package:efk_academy/ui/sign_up/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static const String addReview = '/add_review';
  static const String cart = '/cart';
  static const String courseDetail = '/course_detail';
  static const String changeTheme = '/change_theme';
  static const String changeLanguage = '/change_language';
  static const String changeUsername = '/change_username';
  static const String forgetPassword = '/forget_password';
  static const String news = '/news';
  static const String newDetail = '/new_detail';
  static const String signIn = '/sign_in';
  static const String signOut = '/sign_out';
  static const String signUp = '/sign_up';

  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case changeLanguage:
        return MaterialPageRoute(builder: (_) => const ChangeLanguagePage());
      case changeTheme:
        return MaterialPageRoute(
          builder: (_) => const ChangeThemePage(),
        );
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
      case courseDetail:
        final course = setting.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => GetEnrollmentCubit(
                  getEnrollment: sl<GetEnrollment>(),
                )..getEnrollment(course.id),
              ),
              BlocProvider(
                create: (_) => GetReviewCubit(
                  getReview: sl<GetReview>(),
                )..getReviews(course.id),
              ),
            ],
            child: CourseDetailPages(
              course: course,
            ),
          ),
        );
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ForgetPasswordCubit(
              forgetPassword: sl<ForgetPassword>(),
            ),
            child: const ForgetPasswordPage(),
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SignInCubit(
              signIn: sl<SignIn>(),
            ),
            child: const SignInPage(),
          ),
        );
      case signOut:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SignOutCubit(
              signOut: sl<SignOut>(),
            ),
            child: const SignOutPage(),
          ),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SignUpCubit(
              signUp: sl<SignUp>(),
            ),
            child: const SignUpPage(),
          ),
        );
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
