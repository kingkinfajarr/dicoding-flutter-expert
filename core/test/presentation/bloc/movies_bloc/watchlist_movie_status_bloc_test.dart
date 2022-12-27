import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_status/watchlist_movie_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus])
void main() {
  late WatchlistMovieStatusBloc watchlistMovieStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(
    () {
      mockGetWatchListStatus = MockGetWatchListStatus();
      watchlistMovieStatusBloc =
          WatchlistMovieStatusBloc(mockGetWatchListStatus);
    },
  );

  test(
    'initial state should be not watchlist',
    () {
      expect(watchlistMovieStatusBloc.state, IsNotWatchlistMovies());
    },
  );

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'Should emit [IsWatchlistMovies] when data is gotten successfully',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    expect: () => [
      IsWatchlistMovies(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(1));
    },
  );

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'Should emit [IsNotWatchlistMovies] when data is gotten unsuccessful',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
      return watchlistMovieStatusBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    expect: () => [
      IsNotWatchlistMovies(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(1));
    },
  );
}
