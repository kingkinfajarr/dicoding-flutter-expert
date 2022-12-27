part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent {
  const TvSeriesSearchEvent();
}

class FetchSeriesSearch extends TvSeriesSearchEvent {
  final String query;

  FetchSeriesSearch(this.query);
}
