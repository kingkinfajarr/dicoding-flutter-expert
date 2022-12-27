import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(
    () {
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      TopRatedMoviesLoading(),
      const TopRatedMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
