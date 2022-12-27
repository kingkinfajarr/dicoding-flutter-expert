import 'package:flutter/material.dart';

import '../../../core.dart';
import '../../../domain/entities/tv_series/tvseries.dart';
import '../../../domain/usecases/tv_series/get_now_playing_tv_series.dart';
import '../../../domain/usecases/tv_series/get_popular_tv.dart';
import '../../../domain/usecases/tv_series/get_top_rated_tv.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <TvSeries>[];
  List<TvSeries> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  // Popular TV
  var _popularTv = <TvSeries>[];
  List<TvSeries> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  // Top Rated Tv
  var _topRatedTv = <TvSeries>[];
  List<TvSeries> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTvSeries,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingTv = tvSeriesData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTv = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
