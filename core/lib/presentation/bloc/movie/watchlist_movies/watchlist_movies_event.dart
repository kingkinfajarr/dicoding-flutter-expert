part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent {
  const WatchlistMoviesEvent();
}

class AddWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movie;

  AddWatchlist(this.movie);
}

class RemoveFromWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movie;

  RemoveFromWatchlist(this.movie);
}
