import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Stream<UserModel?> get getUser;
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String username, String password);
  Future<void> signOut();
  Future<void> forgetPassword(String email);
  Future<void> changeUsername(String username);
  Future<void> changePassword(String password, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Stream<UserModel?> get getUser {
    return supabaseClient.auth.onAuthStateChange.asyncMap((data) async {
      final session = data.session;
      final event = data.event;
      if (session == null || event == AuthChangeEvent.signedOut) {
        return null;
      }

      final userJson = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', session.user.id)
          .single();

      return UserModel.fromJson(userJson);
    });
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final signIn = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      if (signIn.user == null) {
        throw const ServerException('user-not-found');
      }

      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', signIn.user!.id)
          .single();

      return UserModel.fromJson(response);
    } on AuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp(
      String email, String username, String password) async {
    try {
      final signUp = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
        },
      );

      if (signUp.user == null) {
        throw const ServerException('user-not-found');
      }

      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', signUp.user!.id)
          .single();

      return UserModel.fromJson(response);
    } on AuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> changeUsername(String username) async {
    try {
      final currentUser = supabaseClient.auth.currentUser;

      if (currentUser == null) {
        throw const ServerException('user-not-found');
      }

      final updatedAt = currentUser.updatedAt;

      if (updatedAt != null) {
        final lastUpdated = DateTime.parse(updatedAt);
        final differences = DateTime.now().difference(lastUpdated).inDays;

        if (differences < 90) {
          throw const ServerException('you-cannot-change');
        }
      }

      await supabaseClient.auth.updateUser(UserAttributes(
        data: {
          'username': username,
        },
      ));
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> changePassword(String password, String newPassword) async {
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser == null) {
      throw const ServerException('user-not-found');
    }

    try {
      final signIn = await supabaseClient.auth.signInWithPassword(
        email: currentUser.email,
        password: password,
      );

      if (signIn.user == null) {
        throw const ServerException('user-not-found');
      }

      await supabaseClient.auth.updateUser(UserAttributes(
        password: newPassword,
      ));
    } on AuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
