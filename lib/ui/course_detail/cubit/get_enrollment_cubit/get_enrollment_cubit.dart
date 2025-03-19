import 'package:efk_academy/domain/usecases/enrollment/get_enrollment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_enrollment_state.dart';

class GetEnrollmentCubit extends Cubit<GetEnrollmentState> {
  GetEnrollmentCubit({
    required GetEnrollment getEnrollment,
  })  : _getEnrollment = getEnrollment,
        super(const GetEnrollmentState());

  final GetEnrollment _getEnrollment;

  Future<void> getEnrollment(String id) async {
    emit(state.copyWith(
      status: GetEnrollmentStatus.inProgress,
    ));

    final response = await _getEnrollment(id);

    response.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: GetEnrollmentStatus.failure,
        ),
      ),
      (isEnrolled) => emit(
        state.copyWith(
          isEnrolled: isEnrolled,
          status: GetEnrollmentStatus.success,
        ),
      ),
    );
  }
}
