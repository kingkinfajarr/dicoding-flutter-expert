part of 'watchlist_tv_series_status_bloc.dart';

abstract class WatchlistTvSeriesStatusState extends Equatable {
  const WatchlistTvSeriesStatusState();

  @override
  List<Object> get props => [];
}

class IsWatchlistTvSeries extends WatchlistTvSeriesStatusState {}

class IsNotWatchlistTvSeries extends WatchlistTvSeriesStatusState {}
