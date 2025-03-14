part of 'feature_cubit.dart';

@immutable
sealed class FeatureState {}

final class FeatureInitial extends FeatureState {}

final class FeatureInProgress extends FeatureState {}

final class FeatureFailure extends FeatureState {
  final String message;
  FeatureFailure(this.message);
}

final class FeatureSuccess extends FeatureState {
  FeatureSuccess(this.posters, this.promotions, this.courses);
  final List<Poster> posters;
  final List<Promotion> promotions;
  final List<Course> courses;
}
