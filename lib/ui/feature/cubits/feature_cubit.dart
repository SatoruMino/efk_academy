import 'package:efk_academy/core/usecase/usecase.dart';
import 'package:efk_academy/domain/entities/course.dart';
import 'package:efk_academy/domain/entities/poster.dart';
import 'package:efk_academy/domain/entities/promotion.dart';
import 'package:efk_academy/domain/usecases/course/get_trending_course.dart';
import 'package:efk_academy/domain/usecases/poster/get_poster.dart';
import 'package:efk_academy/domain/usecases/promotion/get_promotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature_state.dart';

class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit({
    required GetPoster getPoster,
    required GetPromotion getPromotion,
    required GetTrendingCourse getTrendingCourse,
  })  : _getPoster = getPoster,
        _getPromotion = getPromotion,
        _getTrendingCourse = getTrendingCourse,
        super(FeatureInitial());

  final GetPoster _getPoster;
  final GetPromotion _getPromotion;
  final GetTrendingCourse _getTrendingCourse;

  Future<void> getFeature() async {
    emit(FeatureInProgress());

    final posterRes = await _getPoster(NoParam());
    final promotionRes = await _getPromotion(NoParam());
    final trendingRes = await _getTrendingCourse(NoParam());

    posterRes.fold(
      (l) => emit(FeatureFailure(l.message)),
      (posters) => promotionRes.fold(
        (l) => emit(FeatureFailure(l.message)),
        (promotions) => trendingRes.fold(
          (l) => emit(FeatureFailure(l.message)),
          (courses) => emit(
            FeatureSuccess(
              posters,
              promotions,
              courses,
            ),
          ),
        ),
      ),
    );
  }
}
