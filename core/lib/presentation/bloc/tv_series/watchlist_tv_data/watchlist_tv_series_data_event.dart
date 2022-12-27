part of 'watchlist_tv_series_data_bloc.dart';

abstract class WatchlistTvSeriesDataEvent {
  const WatchlistTvSeriesDataEvent();
}

class FetchWatchlistSeries extends WatchlistTvSeriesDataEvent {}
