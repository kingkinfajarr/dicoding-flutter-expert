part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesInitial extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesAdded extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesAdded(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesRemoved extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesRemoved(this.message);

  @override
  List<Object> get props => [message];
}
