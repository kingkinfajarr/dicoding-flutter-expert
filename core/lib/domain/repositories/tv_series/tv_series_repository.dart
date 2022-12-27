import 'package:dartz/dartz.dart';

import '../../../core.dart';
import '../../entities/tv_series/tv_detail.dart';
import '../../entities/tv_series/tvseries.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTv();
  Future<Either<Failure, List<TvSeries>>> getPopularTv();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlist(TvDetail tvDetail);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tvDetail);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
}
