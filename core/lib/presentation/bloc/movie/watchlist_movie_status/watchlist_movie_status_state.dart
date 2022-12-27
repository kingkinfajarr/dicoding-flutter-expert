part of 'watchlist_movie_status_bloc.dart';

abstract class WatchlistMovieStatusState extends Equatable {
  const WatchlistMovieStatusState();

  @override
  List<Object> get props => [];
}

class IsNotWatchlistMovies extends WatchlistMovieStatusState {}

class IsWatchlistMovies extends WatchlistMovieStatusState {}
