part of 'movies_recommendations_bloc.dart';

abstract class MoviesRecommendationsEvent {
  const MoviesRecommendationsEvent();
}

class FetchRecommendations extends MoviesRecommendationsEvent {
  final int id;

  FetchRecommendations(this.id);
}
