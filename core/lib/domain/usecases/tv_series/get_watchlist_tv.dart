import 'package:dartz/dartz.dart';

import '../../../core.dart';
import '../../entities/tv_series/tvseries.dart';
import '../../repositories/tv_series/tv_series_repository.dart';

class GetWatchlistTv {
  final TvSeriesRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTv();
  }
}
