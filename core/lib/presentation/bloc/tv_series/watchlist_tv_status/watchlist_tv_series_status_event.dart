part of 'watchlist_tv_series_status_bloc.dart';

abstract class WatchlistTvSeriesStatusEvent {
  const WatchlistTvSeriesStatusEvent();
}

class LoadWatchlistStatus extends WatchlistTvSeriesStatusEvent {
  final int id;

  LoadWatchlistStatus(this.id);
}
