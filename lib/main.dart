import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/theme_notifier/theme_notifier.dart';
import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await setUpLocator();
  runApp(
    EasyLocalization(
      supportedLocales: [AppLocalizations.khLocale, AppLocalizations.engLocale],
      path: AppLocalizations.translationPath,
      fallbackLocale: AppLocalizations.engLocale,
      saveLocale: true,
      startLocale: AppLocalizations.engLocale,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(sharedPreferences: sl()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => sl<UserCubit>()..getUser(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: light,
            darkTheme: dark,
            themeMode: context.watch<ThemeNotifier>().themeMode,
            navigatorKey: AppNavigator.navigatorKey,
            scaffoldMessengerKey: AppToast.scaffoldMessengerKey,
            home: child,
          ),
        );
      },
      child: const SplashPage(),
    );
  }
}
