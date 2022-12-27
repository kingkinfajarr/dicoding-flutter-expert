import 'package:flutter/cupertino.dart';

import '../../../core.dart';
import '../../../domain/entities/tv_series/tvseries.dart';
import '../../../domain/usecases/tv_series/get_now_playing_tv_series.dart';

class NowPlayingTvNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvNotifier({required this.getNowPlayingTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tvSeries = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
