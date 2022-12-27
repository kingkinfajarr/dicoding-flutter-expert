import '../../repositories/tv_series/tv_series_repository.dart';

class GetWatchListTvStatus {
  final TvSeriesRepository repository;

  GetWatchListTvStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
