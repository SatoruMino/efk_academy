import 'package:efk_academy/core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class EnrollmentRemoteDataSource {
  Future<bool> getEnrollment(String courseId);
}

class EnrollmentRemoteDataSourceImpl implements EnrollmentRemoteDataSource {
  const EnrollmentRemoteDataSourceImpl(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<bool> getEnrollment(String courseId) async {
    try {
      final currentUser = supabaseClient.auth.currentUser;

      if (currentUser == null) {
        return false;
      }

      final response = await supabaseClient
          .from('enrollments')
          .select('id')
          .eq('user_id', currentUser.id)
          .eq('course_id', courseId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
