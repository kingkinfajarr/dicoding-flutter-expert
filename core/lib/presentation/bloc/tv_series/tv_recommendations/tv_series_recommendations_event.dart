part of 'tv_series_recommendations_bloc.dart';

abstract class TvSeriesRecommendationsEvent {
  const TvSeriesRecommendationsEvent();
}

class FetchRecommendations extends TvSeriesRecommendationsEvent {
  final int id;

  FetchRecommendations(this.id);
}
