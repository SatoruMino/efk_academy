import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/core/helpers/helpers.dart';
import 'package:efk_academy/domain/usecases/auth/get_user.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/splash/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      child: BlocProvider(
        create: (_) => UserCubit(
          getUser: sl<GetUser>(),
        ),
        child: const MyApp(),
      ),
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
        return MaterialApp(
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
        );
      },
      child: const SplashPage(),
    );
  }
}
