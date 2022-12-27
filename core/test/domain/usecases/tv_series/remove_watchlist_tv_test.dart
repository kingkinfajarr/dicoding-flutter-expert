import 'package:core/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTv(mockTvSeriesRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvSeriesRepository.removeWatchlist(testTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
