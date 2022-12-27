import 'package:flutter/cupertino.dart';

import '../../../core.dart';
import '../../../domain/entities/tv_series/tvseries.dart';
import '../../../domain/usecases/tv_series/get_popular_tv.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTv getPopularTv;

  PopularTvNotifier(this.getPopularTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();

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
