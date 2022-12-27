import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv/watchlist_tv_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockSaveWatchlistTv mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTv mockRemoveWatchlistSeries;

  setUp(
    () {
      mockSaveWatchlistTvSeries = MockSaveWatchlistTv();
      mockRemoveWatchlistSeries = MockRemoveWatchlistTv();
      watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
        saveWatchlist: mockSaveWatchlistTvSeries,
        removeWatchlist: mockRemoveWatchlistSeries,
      );
    },
  );

  test(
    'initial state should be WatchlistTvSeriesInitial',
    () {
      expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesInitial());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesAdded] when data is added successfully',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testTvDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      const WatchlistTvSeriesAdded('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesError] when data is added unsuccessfull',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testTvDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      const WatchlistTvSeriesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesRemoved] when data is removed successfully',
    build: () {
      when(mockRemoveWatchlistSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      const WatchlistTvSeriesRemoved('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistSeries.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesError] when data is removed unsuccessfull',
    build: () {
      when(mockRemoveWatchlistSeries.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      const WatchlistTvSeriesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistSeries.execute(testTvDetail));
    },
  );
}
