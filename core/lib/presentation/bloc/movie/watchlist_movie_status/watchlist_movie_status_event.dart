part of 'watchlist_movie_status_bloc.dart';

abstract class WatchlistMovieStatusEvent {
  const WatchlistMovieStatusEvent();
}

class LoadWatchlistStatus extends WatchlistMovieStatusEvent {
  final int id;

  LoadWatchlistStatus(this.id);
}
