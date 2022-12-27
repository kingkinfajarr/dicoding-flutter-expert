import 'package:dartz/dartz.dart';

import '../../../core.dart';
import '../../entities/tv_series/tvseries.dart';
import '../../repositories/tv_series/tv_series_repository.dart';

class GetTopRatedTv {
  final TvSeriesRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTv();
  }
}
