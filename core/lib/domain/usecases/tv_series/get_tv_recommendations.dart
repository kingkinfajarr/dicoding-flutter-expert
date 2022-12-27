import 'package:dartz/dartz.dart';

import '../../../core.dart';
import '../../entities/tv_series/tvseries.dart';
import '../../repositories/tv_series/tv_series_repository.dart';

class GetTvRecommendations {
  final TvSeriesRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
