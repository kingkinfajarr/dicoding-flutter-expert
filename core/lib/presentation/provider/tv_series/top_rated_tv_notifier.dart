import 'package:flutter/cupertino.dart';

import '../../../core.dart';
import '../../../domain/entities/tv_series/tvseries.dart';
import '../../../domain/usecases/tv_series/get_top_rated_tv.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvNotifier({required this.getTopRatedTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _tvSeries = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
