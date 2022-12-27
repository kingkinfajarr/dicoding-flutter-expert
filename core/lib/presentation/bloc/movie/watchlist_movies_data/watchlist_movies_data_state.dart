part of 'watchlist_movies_data_bloc.dart';

abstract class WatchlistMoviesDataState extends Equatable {
  const WatchlistMoviesDataState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesDataEmpty extends WatchlistMoviesDataState {}

class WatchlistMoviesDataLoading extends WatchlistMoviesDataState {}

class WatchlistMoviesDataError extends WatchlistMoviesDataState {
  final String message;

  const WatchlistMoviesDataError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesDataHasData extends WatchlistMoviesDataState {
  final List<Movie> result;

  const WatchlistMoviesDataHasData(this.result);

  @override
  List<Object> get props => [result];
}
