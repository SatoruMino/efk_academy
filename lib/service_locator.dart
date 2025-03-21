import 'dart:async';
import 'package:efk_academy/common/cubits/cart_cubit/cart_cubit.dart';
import 'package:efk_academy/common/cubits/get_new_cubit/get_new_cubit.dart';
import 'package:efk_academy/common/cubits/user_cubit/user_cubit.dart';
import 'package:efk_academy/data/datasources/enrollment_remote_data_source.dart';
import 'package:efk_academy/data/repositories/enrollment_repository_impl.dart';
import 'package:efk_academy/domain/repositories/enrollment_repository.dart';
import 'package:efk_academy/domain/usecases/auth/forget_password.dart';
import 'package:efk_academy/domain/usecases/enrollment/get_enrollment.dart';
import 'package:efk_academy/ui/course/cubits/get_course_cubit.dart';
import 'package:efk_academy/ui/course_detail/cubit/get_enrollment_cubit/get_enrollment_cubit.dart';
import 'package:efk_academy/ui/course_detail/cubit/get_review_cubit/get_review_cubit.dart';
import 'package:efk_academy/ui/feature/cubits/feature_cubit.dart';
import 'package:efk_academy/ui/sign_in/cubits/sign_in_cubit.dart';
import 'package:efk_academy/ui/sign_out/cubit/sign_out_cubit.dart';
import 'package:efk_academy/ui/sign_up/cubits/sign_up_cubit.dart';
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
  _initProviders();
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
    ..registerSingleton<CartRemoteDataSource>(
      CartRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<CourseRemoteDataSource>(
      CourseRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<EnrollmentRemoteDataSource>(
      EnrollmentRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<NewRemoteDataSource>(
      NewRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<PosterRemoteDataSource>(
      PosterRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<PromotionRemoteDataSource>(
      PromotionRemoteDataSourceImpl(sl()),
    )
    ..registerSingleton<ReviewRemoteDataSource>(
      ReviewRemoteDataSourceImpl(sl()),
    );
}

_initRepositories() {
  sl
    ..registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()))
    ..registerSingleton<CartRepository>(CartRepositoryImpl(sl()))
    ..registerSingleton<CourseRepository>(CourseRepositoryImpl(sl()))
    ..registerSingleton<EnrollmentRepository>(EnrollmentRepositoryImpl(sl()))
    ..registerSingleton<NewRepository>(NewRepositoryImpl(sl()))
    ..registerSingleton<PosterRepository>(PosterRepositoryImpl(sl()))
    ..registerSingleton<PromotionRepository>(PromotionRepositoryImpl(sl()))
    ..registerSingleton<ReviewRepository>(ReviewRepositoryImpl(sl()));
}

_initUsecases() {
  sl
    ..registerSingleton(AddToCart(sl()))
    ..registerSingleton(ChangeUsername(sl()))
    ..registerSingleton(ChangePassword(sl()))
    ..registerSingleton(ForgetPassword(sl()))
    ..registerSingleton(GetCart(sl()))
    ..registerSingleton(GetCourse(sl()))
    ..registerSingleton(GetEnrollment(sl()))
    ..registerSingleton(GetNew(sl()))
    ..registerSingleton(GetPoster(sl()))
    ..registerSingleton(GetPromotion(sl()))
    ..registerSingleton(GetReview(sl()))
    ..registerSingleton(GetTrendingCourse(sl()))
    ..registerSingleton(GetUser(sl()))
    ..registerSingleton(RemoveFromCart(sl()))
    ..registerSingleton(SignIn(sl()))
    ..registerSingleton(SignOut(sl()))
    ..registerSingleton(SignUp(sl()));
}

_initProviders() {
  sl
    ..registerLazySingleton(
      () => CartCubit(
        getCart: sl<GetCart>(),
        addToCart: sl<AddToCart>(),
        removeFromCart: sl<RemoveFromCart>(),
      ),
    )
    ..registerLazySingleton(
      () => GetCourseCubit(
        getCourse: sl<GetCourse>(),
      ),
    )
    ..registerFactory(
      () => GetEnrollmentCubit(
        getEnrollment: sl<GetEnrollment>(),
      ),
    )
    ..registerFactory(
      () => GetReviewCubit(
        getReview: sl<GetReview>(),
      ),
    )
    ..registerLazySingleton(
      () => FeatureCubit(
        getPoster: sl<GetPoster>(),
        getPromotion: sl<GetPromotion>(),
        getTrendingCourse: sl<GetTrendingCourse>(),
      ),
    )
    ..registerLazySingleton(
      () => GetNewCubit(
        getNew: sl<GetNew>(),
      ),
    )
    ..registerFactory(
      () => SignInCubit(
        signIn: sl<SignIn>(),
      ),
    )
    ..registerFactory(
      () => SignUpCubit(
        signUp: sl<SignUp>(),
      ),
    )
    ..registerFactory(
      () => SignOutCubit(
        signOut: sl<SignOut>(),
      ),
    )
    ..registerLazySingleton(
      () => UserCubit(
        getUser: sl<GetUser>(),
      ),
    );
}
