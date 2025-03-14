import 'dart:async';

import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/datasources/auth_remote_data_source.dart';
import 'package:efk_academy/data/datasources/course_remote_data_source.dart';
import 'package:efk_academy/data/datasources/new_remote_data_source.dart';
import 'package:efk_academy/data/datasources/poster_remote_data_source.dart';
import 'package:efk_academy/data/datasources/promotion_remote_data_source.dart';
import 'package:efk_academy/data/repositories/auth_repository_impl.dart';
import 'package:efk_academy/data/repositories/course_repository_impl.dart';
import 'package:efk_academy/data/repositories/new_repository_impl.dart';
import 'package:efk_academy/data/repositories/poster_repository_impl.dart';
import 'package:efk_academy/data/repositories/promotion_repository_impl.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:efk_academy/domain/repositories/course_repository.dart';
import 'package:efk_academy/domain/repositories/new_repository.dart';
import 'package:efk_academy/domain/repositories/poster_repository.dart';
import 'package:efk_academy/domain/repositories/promotion_repository.dart';
import 'package:efk_academy/domain/usecases/auth/change_username.dart';
import 'package:efk_academy/domain/usecases/auth/get_user.dart';
import 'package:efk_academy/domain/usecases/auth/sign_in.dart';
import 'package:efk_academy/domain/usecases/auth/sign_up.dart';
import 'package:efk_academy/domain/usecases/course/get_course.dart';
import 'package:efk_academy/domain/usecases/course/get_trending_course.dart';
import 'package:efk_academy/domain/usecases/new/get_new.dart';
import 'package:efk_academy/domain/usecases/poster/get_poster.dart';
import 'package:efk_academy/domain/usecases/promotion/get_promotion.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

void setUpLocator() async {
  await _initDatabase();
  _initDataSource();
  _initRepositories();
  _initUsecases();
}

Future<void> _initDatabase() async {
  final supabase =
      await Supabase.initialize(url: Secret.url, anonKey: Secret.key);

  sl.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );
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
    ..registerSingleton<AuthRepository>(
      AuthRepositoryImpl(sl()),
    )
    ..registerSingleton<CourseRepository>(
      CourseRepositoryImpl(sl()),
    )
    ..registerSingleton<NewRepository>(
      NewRepositoryImpl(sl()),
    )
    ..registerSingleton<PosterRepository>(
      PosterRepositoryImpl(sl()),
    )
    ..registerSingleton<PromotionRepository>(
      PromotionRepositoryImpl(sl()),
    );
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
    ..registerSingleton(SignUp(sl()));
}
