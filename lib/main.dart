import 'package:efk_academy/common/cubits/cart_cubit/cart_cubit.dart';
import 'package:efk_academy/common/cubits/get_new_cubit/get_new_cubit.dart';
import 'package:efk_academy/ui/course/cubits/get_course_cubit.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:efk_academy/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:efk_academy/ui/splash/page/splash_page.dart';
import 'package:efk_academy/common/cubits/user_cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  setUpLocator();
  runApp(
    EasyLocalization(
      supportedLocales: [AppLocalizations.khLocale, AppLocalizations.engLocale],
      path: AppLocalizations.path,
      fallbackLocale: AppLocalizations.engLocale,
      saveLocale: true,
      startLocale: AppLocalizations.engLocale,
      useFallbackTranslations: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            // .. user
            BlocProvider(
              create: (_) => sl<UserCubit>(),
            ),

            // .. cart
            BlocProvider(
              create: (_) => sl<CartCubit>()..getCarts(),
            ),

            // .. new
            BlocProvider(
              create: (_) => sl<GetNewCubit>()..getNews(),
            ),

            // .. feature
            BlocProvider(
              create: (_) => sl<FeatureCubit>()..getFeature(),
            ),

            // .. feature
            BlocProvider(
              create: (_) => sl<GetCourseCubit>()..getCourses(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: AppTheme.light(locale),
            darkTheme: AppTheme.dark(locale),
            themeMode: ThemeMode.light,
            navigatorKey: NavigatorHelper.navigatorKey,
            scaffoldMessengerKey: Toast.scaffoldMessengerKey,
            home: child,
            onGenerateRoute: AppRoute.onGenerateRoute,
          ),
        );
      },
      child: const SplashPage(),
    );
  }
}
