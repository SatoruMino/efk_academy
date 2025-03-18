import 'package:efk_academy/domain/usecases/enrollment/get_enrollment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetEnrollmentCubit extends Cubit<bool> {
  GetEnrollmentCubit({
    required GetEnrollment getEnrollment,
  })  : _getEnrollment = getEnrollment,
        super(false);

  final GetEnrollment _getEnrollment;

  Future<void> getEnrollment(String id) async {
    final response = await _getEnrollment(id);

    response.fold(
      (l) => emit(false),
      (isEnrolled) => emit(isEnrolled),
    );
  }
}
