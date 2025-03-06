import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:efk_academy/domain/usecases/new/get_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_new_state.dart';

class GetNewCubit extends Cubit<GetNewState> {
  GetNewCubit({
    required GetNew getNew,
  })  : _getNew = getNew,
        super(GetNewInitial());

  final GetNew _getNew;

  Future<void> getNews() async {
    emit(GetNewInProgress());

    final res = await _getNew(NoParam());

    res.fold(
      (l) => emit(
        GetNewFailure(
          l.message,
        ),
      ),
      (news) => emit(
        GetNewSuccess(
          news,
        ),
      ),
    );
  }
}
