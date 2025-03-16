import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/data.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

void setUpLocator() async {
  await _initDatabase();
  _initDataSource();
  _initRepositories();
  _initUsecases();
}

Future<void> _initDatabase() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  final supabase = await Supabase.initialize(
    url: Secret.url,
    anonKey: Secret.key,
  );

  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);
}

_initDataSource() {
  sl
    ..registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<CourseRemoteDataSource>(
      CourseRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<NewRemoteDataSource>(
      NewRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<PosterRemoteDataSource>(
      PosterRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<PromotionRemoteDataSource>(
      PromotionRemoteDataSourceImpl(sl()),
    );
}

_initRepositories() {
  sl
    ..registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()))
    ..registerSingleton<CourseRepository>(CourseRepositoryImpl(sl()))
    ..registerSingleton<NewRepository>(NewRepositoryImpl(sl()))
    ..registerSingleton<PosterRepository>(PosterRepositoryImpl(sl()))
    ..registerSingleton<PromotionRepository>(PromotionRepositoryImpl(sl()));
}

_initUsecases() {
  sl
    ..registerSingleton(ChangeUsername(sl()))
    ..registerSingleton(GetCourse(sl()))
    ..registerSingleton(GetNew(sl()))
    ..registerSingleton(GetPoster(sl()))
    ..registerSingleton(GetPromotion(sl()))
    ..registerSingleton(GetTrendingCourse(sl()))
    ..registerSingleton(GetUser(sl()))
    ..registerSingleton(SignIn(sl()))
    ..registerSingleton(SignOut(sl()))
    ..registerSingleton(SignUp(sl()));
}
