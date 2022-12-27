part of 'watchlist_movies_data_bloc.dart';

abstract class WatchlistMoviesDataEvent {
  const WatchlistMoviesDataEvent();
}

class FetchWatchlistMovies extends WatchlistMoviesDataEvent {}
