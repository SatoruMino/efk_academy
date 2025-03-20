part of 'get_new_cubit.dart';

enum GetNewStatus { initial, inProgress, failure, success }

final class GetNewState extends Equatable {
  const GetNewState({
    this.news = const [],
    this.errorMessage = '',
    this.status = GetNewStatus.initial,
  });

  final List<New> news;
  final String errorMessage;
  final GetNewStatus status;

  @override
  List<Object?> get props => [news, errorMessage, status];

  GetNewState copyWith({
    List<New>? news,
    String? errorMessage,
    GetNewStatus? status,
  }) {
    return GetNewState(
      news: news ?? this.news,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
