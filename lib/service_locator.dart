import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/constant/constant.dart';
import 'package:efk_academy/data/datasources/auth_remote_data_source.dart';
import 'package:efk_academy/data/datasources/course_remote_data_source.dart';
import 'package:efk_academy/data/datasources/new_remote_data_source.dart';
import 'package:efk_academy/data/datasources/poster_remote_data_source.dart';
import 'package:efk_academy/data/datasources/promotion_remote_data_source.dart';
import 'package:efk_academy/data/datasources/review_remote_data_source.dart';
import 'package:efk_academy/data/datasources/user_remote_data_source.dart';
import 'package:efk_academy/data/repositories/auth_repository_impl.dart';
import 'package:efk_academy/data/repositories/course_repository_impl.dart';
import 'package:efk_academy/data/repositories/new_repository_impl.dart';
import 'package:efk_academy/data/repositories/poster_repository_impl.dart';
import 'package:efk_academy/data/repositories/promotion_repository_impl.dart';
import 'package:efk_academy/data/repositories/review_repository_impl.dart';
import 'package:efk_academy/data/repositories/user_repository_impl.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:efk_academy/domain/repositories/course_repository.dart';
import 'package:efk_academy/domain/repositories/new_repository.dart';
import 'package:efk_academy/domain/repositories/poster_repository.dart';
import 'package:efk_academy/domain/repositories/promotion_repository.dart';
import 'package:efk_academy/domain/repositories/review_repository.dart';
import 'package:efk_academy/domain/repositories/user_repository.dart';
import 'package:efk_academy/domain/usecases/auth/sign_in_with_password.dart';
import 'package:efk_academy/domain/usecases/auth/sign_out.dart';
import 'package:efk_academy/domain/usecases/auth/sign_up_with_password.dart';
import 'package:efk_academy/domain/usecases/course/get_course.dart';
import 'package:efk_academy/domain/usecases/course/get_trending_course.dart';
import 'package:efk_academy/domain/usecases/course/search_course_by_category.dart';
import 'package:efk_academy/domain/usecases/course/search_course_by_name.dart';
import 'package:efk_academy/domain/usecases/new/get_new.dart';
import 'package:efk_academy/domain/usecases/poster/get_poster.dart';
import 'package:efk_academy/domain/usecases/promotion/get_promotion.dart';
import 'package:efk_academy/domain/usecases/review/add_review.dart';
import 'package:efk_academy/domain/usecases/review/get_review.dart';
import 'package:efk_academy/domain/usecases/user/change_password.dart';
import 'package:efk_academy/domain/usecases/user/change_username.dart';
import 'package:efk_academy/domain/usecases/user/get_user.dart';
import 'package:efk_academy/ui/add_review/cubits/add_review_cubit.dart';
import 'package:efk_academy/ui/change_password/cubit/change_password_cubit.dart';
import 'package:efk_academy/ui/change_username/cubits/change_username_cubit.dart';
import 'package:efk_academy/ui/course/cubits/get_course_cubit.dart';
import 'package:efk_academy/ui/course_detail/cubits/get_review_cubit/get_review_cubit.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:efk_academy/ui/new/cubit/get_new_cubit.dart';
import 'package:efk_academy/ui/sign_in/cubits/sign_in_cubit.dart';
import 'package:efk_academy/ui/sign_out/cubit/sign_out_cubit.dart';
import 'package:efk_academy/ui/sign_up/cubits/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> setUpLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  final supabase = await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  sl.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );

  initDataSources();
  initRepositories();
  initUsecases();
  initProviders();
}

void initDataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<CourseRemoteDataSource>(
    () => CourseRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<NewRemoteDataSource>(
    () => NewRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<PosterRemoteDataSource>(
    () => PosterRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<PromotionRemoteDataSource>(
    () => PromotionRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      sl(),
    ),
  );
}

void initRepositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<NewRepository>(
    () => NewRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<PosterRepository>(
    () => PosterRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<PromotionRepository>(
    () => PromotionRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      sl(),
    ),
  );
}

void initUsecases() {
  sl.registerSingleton(
    AddReview(
      sl(),
    ),
  );
  sl.registerSingleton(
    ChangePassword(
      sl(),
    ),
  );
  sl.registerSingleton(
    ChangeUsername(
      sl(),
    ),
  );
  sl.registerSingleton(
    GetCourse(
      sl(),
    ),
  );
  sl.registerSingleton(
    GetNew(
      sl(),
    ),
  );
  sl.registerSingleton(
    GetPoster(
      sl(),
    ),
  );
  sl.registerSingleton(
    GetPromotion(
      sl(),
    ),
  );
  sl.registerSingleton(
    GetReview(
      sl(),
    ),
  );
  sl.registerSingleton(
    GetTrendingCourse(
      sl(),
    ),
  );
  sl.registerSingleton(
    GetUser(
      sl(),
    ),
  );
  sl.registerSingleton(
    SearchCourseByCategory(
      sl(),
    ),
  );
  sl.registerSingleton(
    SearchCourseByName(
      sl(),
    ),
  );
  sl.registerSingleton(
    SignInWithPassword(
      sl(),
    ),
  );
  sl.registerSingleton(
    SignOut(
      sl(),
    ),
  );
  sl.registerSingleton(
    SignUpWithPassword(
      sl(),
    ),
  );
}

void initProviders() {
  sl.registerSingleton(
    UserCubit(
      getUser: sl(),
    ),
  );

  sl.registerFactory(
    () => ChangePasswordCubit(
      changePassword: sl(),
    ),
  );
  sl.registerFactory(
    () => ChangeUsernameCubit(
      changeUsername: sl(),
      userCubit: sl(),
    ),
  );
  sl.registerSingleton(
    GetCourseCubit(
      getCourse: sl(),
    ),
  );
  sl.registerFactory(
    () => GetNewCubit(
      getNew: sl(),
    ),
  );
  sl.registerFactory(
    () => GetReviewCubit(
      getReview: sl(),
    ),
  );
  sl.registerFactory(
    () => AddReviewCubit(
      addReview: sl(),
    ),
  );

  sl.registerSingleton(
    FeatureCubit(
      getPoster: sl(),
      getPromotion: sl(),
      getTrendingCourse: sl(),
    ),
  );

  sl.registerFactory(
    () => SignInCubit(
      signInWithPassword: sl(),
      userCubit: sl(),
    ),
  );
  sl.registerFactory(
    () => SignOutCubit(
      signOut: sl(),
      userCubit: sl(),
    ),
  );
  sl.registerFactory(
    () => SignUpCubit(
      signUpWithPassword: sl(),
      userCubit: sl(),
    ),
  );
}
