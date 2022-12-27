part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent {
  const TvSeriesDetailEvent();
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  FetchTvSeriesDetail(this.id);
}
