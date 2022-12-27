part of 'movies_recommendations_bloc.dart';

abstract class MoviesRecommendationsState extends Equatable {
  const MoviesRecommendationsState();

  @override
  List<Object> get props => [];
}

class MoviesRecommendationsEmpty extends MoviesRecommendationsState {}

class MoviesRecommendationsLoading extends MoviesRecommendationsState {}

class MoviesRecommendationsError extends MoviesRecommendationsState {
  final String message;

  const MoviesRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesRecommendationsHasData extends MoviesRecommendationsState {
  final List<Movie> recommendations;

  const MoviesRecommendationsHasData(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}
