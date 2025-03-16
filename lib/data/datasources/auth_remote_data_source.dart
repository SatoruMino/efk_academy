import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Stream<UserModel?> get getUser;
  Future<void> signIn(String email, String password);
  Future<void> signUp(String username, String email, String password);
  Future<void> signOut();
  Future<void> forgetPassword(String email);
  Future<void> changeUsername(String username);
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
  Future<void> signIn(String email, String password) async {
    try {
      await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signUp(String username, String email, String password) async {
    try {
      await supabaseClient.auth.signUp(email: email, password: password, data: {
        'username': username,
      });
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
}
