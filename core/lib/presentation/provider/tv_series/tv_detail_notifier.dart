import 'package:flutter/cupertino.dart';

import '../../../core.dart';
import '../../../domain/entities/tv_series/tv_detail.dart';
import '../../../domain/entities/tv_series/tvseries.dart';
import '../../../domain/usecases/tv_series/get_tv_detail.dart';
import '../../../domain/usecases/tv_series/get_tv_recommendations.dart';
import '../../../domain/usecases/tv_series/get_watchlist_tv_status.dart';
import '../../../domain/usecases/tv_series/remove_watchlist_tv.dart';
import '../../../domain/usecases/tv_series/save_watchlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListTvStatus getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  // Tv Detail
  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  // Tv Recommendations
  List<TvSeries> _tvRecommendations = [];
  List<TvSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvDetail) {
        _recommendationState = RequestState.Loading;
        _tvDetail = tvDetail;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvDetail) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tvDetail;
          },
        );
        _tvDetailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tvDetail) async {
    final result = await saveWatchlist.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> removeFromWatchlist(TvDetail tvDetail) async {
    final result = await removeWatchlist.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
