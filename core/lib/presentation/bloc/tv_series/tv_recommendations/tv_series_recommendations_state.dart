part of 'tv_series_recommendations_bloc.dart';

abstract class TvSeriesRecommendationsState extends Equatable {
  const TvSeriesRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationsEmpty extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsLoading extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsError extends TvSeriesRecommendationsState {
  final String message;

  const TvSeriesRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesRecommendationsHasData extends TvSeriesRecommendationsState {
  final List<TvSeries> recommendations;

  const TvSeriesRecommendationsHasData(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}
