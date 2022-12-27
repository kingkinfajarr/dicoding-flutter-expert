part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesInitial extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesAdded extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesAdded(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesRemoved extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesRemoved(this.message);

  @override
  List<Object> get props => [message];
}
