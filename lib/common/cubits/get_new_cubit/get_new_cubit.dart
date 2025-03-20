import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:efk_academy/domain/usecases/new/get_new.dart';

part 'get_new_state.dart';

class GetNewCubit extends Cubit<GetNewState> {
  GetNewCubit({
    required GetNew getNew,
  })  : _getNew = getNew,
        super(const GetNewState());

  final GetNew _getNew;

  Future<void> getNews() async {
    emit(state.copyWith(
      status: GetNewStatus.inProgress,
    ));

    final res = await _getNew(NoParam());

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: GetNewStatus.failure,
        ),
      ),
      (news) => emit(
        state.copyWith(
          news: news,
          status: GetNewStatus.success,
        ),
      ),
    );
  }
}
