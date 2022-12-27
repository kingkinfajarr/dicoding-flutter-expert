import 'package:dartz/dartz.dart';

import '../../../core.dart';
import '../../entities/tv_series/tv_detail.dart';
import '../../repositories/tv_series/tv_series_repository.dart';

class GetTvDetail {
  final TvSeriesRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
