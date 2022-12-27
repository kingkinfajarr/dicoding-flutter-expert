import 'package:core/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTv(mockTvSeriesRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvSeriesRepository.saveWatchlist(testTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
