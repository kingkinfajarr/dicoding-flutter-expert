part of 'watchlist_tv_series_data_bloc.dart';

abstract class WatchlistTvSeriesDataState extends Equatable {
  const WatchlistTvSeriesDataState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesDataEmpty extends WatchlistTvSeriesDataState {}

class WatchlistTvSeriesDataLoading extends WatchlistTvSeriesDataState {}

class WatchlistTvSeriesDataError extends WatchlistTvSeriesDataState {
  final String message;

  const WatchlistTvSeriesDataError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesDataHasData extends WatchlistTvSeriesDataState {
  final List<TvSeries> result;

  const WatchlistTvSeriesDataHasData(this.result);

  @override
  List<Object> get props => [result];
}
