import 'dart:async';

import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/datasources/auth_remote_data_source.dart';
import 'package:efk_academy/data/repositories/auth_repository_impl.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:efk_academy/domain/usecases/auth/change_username.dart';
import 'package:efk_academy/domain/usecases/auth/get_user.dart';
import 'package:efk_academy/domain/usecases/auth/sign_in.dart';
import 'package:efk_academy/domain/usecases/auth/sign_up.dart';
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
  sl.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(sl()),
  );
}

_initRepositories() {
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl()),
  );
}

_initUsecases() {
  sl.registerSingleton(ChangeUsername(sl()));
  sl.registerSingleton(GetUser(sl()));
  sl.registerSingleton(SignIn(sl()));
  sl.registerSingleton(SignUp(sl()));
}
