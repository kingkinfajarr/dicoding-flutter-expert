import 'package:dartz/dartz.dart';

import '../../../core.dart';
import '../../entities/tv_series/tv_detail.dart';
import '../../repositories/tv_series/tv_series_repository.dart';

class SaveWatchlistTv {
  final TvSeriesRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.saveWatchlist(tvDetail);
  }
}
