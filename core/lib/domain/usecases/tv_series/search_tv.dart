import 'package:dartz/dartz.dart';

import '../../../core.dart';
import '../../entities/tv_series/tvseries.dart';
import '../../repositories/tv_series/tv_series_repository.dart';

class SearchTv {
  final TvSeriesRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTv(query);
  }
}
