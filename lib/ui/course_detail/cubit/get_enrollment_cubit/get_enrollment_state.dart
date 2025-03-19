part of 'get_enrollment_cubit.dart';

enum GetEnrollmentStatus { initial, inProgress, failure, success }

final class GetEnrollmentState extends Equatable {
  const GetEnrollmentState({
    this.isEnrolled = false,
    this.errorMessage = '',
    this.status = GetEnrollmentStatus.initial,
  });

  final bool isEnrolled;
  final String errorMessage;
  final GetEnrollmentStatus status;

  @override
  List<Object?> get props => [isEnrolled, errorMessage, status];

  GetEnrollmentState copyWith({
    bool? isEnrolled,
    String? errorMessage,
    GetEnrollmentStatus? status,
  }) {
    return GetEnrollmentState(
      isEnrolled: isEnrolled ?? this.isEnrolled,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
