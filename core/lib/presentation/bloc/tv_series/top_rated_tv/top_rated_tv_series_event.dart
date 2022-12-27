part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesEvent {
  const TopRatedTvSeriesEvent();
}

class FetchTopRatedSeries extends TopRatedTvSeriesEvent {}
