import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class UserRemoteDataSource {
  Session? get currentSession;
  Future<UserModel?> getUser();
  Future<UserModel> changeUsername(String username);
  Future<UserModel> changePassword(String currentPassword, String newPassword);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final SupabaseClient supabaseClient;

  const UserRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getUser() async {
    try {
      if (currentSession == null) {
        return null;
      }

      final resposne = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentSession!.user.id)
          .single();

      return UserModel.fromJson(resposne);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> changeUsername(String username) async {
    try {
      if (currentSession == null) {
        throw const ServerException('user-not-found');
      }

      final user = await supabaseClient
          .from('profiles')
          .update({
            'username': username,
          })
          .eq('id', currentSession!.user.id)
          .select()
          .single();

      return UserModel.fromJson(user);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    if (currentSession == null) {
      throw ServerException('user-not-found');
    }

    try {
      final signIn = await supabaseClient.auth.signInWithPassword(
        email: currentSession!.user.email,
        password: currentPassword,
      );

      if (signIn.user == null) {
        throw ServerException('wrong-password');
      }

      final response = await supabaseClient.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );

      if (response.user == null) {
        throw const ServerException('user-not-found');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
