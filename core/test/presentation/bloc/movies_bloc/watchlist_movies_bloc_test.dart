import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/movie/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(
    () {
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();
      watchlistMoviesBloc = WatchlistMoviesBloc(
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
      );
    },
  );

  test(
    'initial state should be WatchlistMoviesInitial',
    () {
      expect(watchlistMoviesBloc.state, WatchlistMoviesInitial());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [WatchlistMoviesAdded] when data is added successfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    expect: () => [
      WatchlistMoviesInitial(),
      const WatchlistMoviesAdded('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [WatchlistMoviesError] when data is added unsuccessfull',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    expect: () => [
      WatchlistMoviesInitial(),
      const WatchlistMoviesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [WatchlistMoviesRemoved] when data is removed successfully',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    expect: () => [
      WatchlistMoviesInitial(),
      const WatchlistMoviesRemoved('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [WatchlistMoviesError] when data is removed unsuccessfull',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    expect: () => [
      WatchlistMoviesInitial(),
      const WatchlistMoviesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
