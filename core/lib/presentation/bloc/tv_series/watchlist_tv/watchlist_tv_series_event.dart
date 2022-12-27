part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent {
  const WatchlistTvSeriesEvent();
}

class AddWatchlist extends WatchlistTvSeriesEvent {
  final TvDetail series;

  AddWatchlist(this.series);
}

class RemoveFromWatchlist extends WatchlistTvSeriesEvent {
  final TvDetail series;

  RemoveFromWatchlist(this.series);
}
