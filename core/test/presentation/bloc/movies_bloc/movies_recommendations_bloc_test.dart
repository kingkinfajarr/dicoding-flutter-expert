import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movie/movie_recommendations/movies_recommendations_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movies_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MoviesRecommendationsBloc moviesRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(
    () {
      mockGetMovieRecommendations = MockGetMovieRecommendations();
      moviesRecommendationsBloc =
          MoviesRecommendationsBloc(mockGetMovieRecommendations);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(moviesRecommendationsBloc.state, MoviesRecommendationsEmpty());
    },
  );

  blocTest<MoviesRecommendationsBloc, MoviesRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(testMovieList));
      return moviesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendations(1)),
    expect: () => [
      MoviesRecommendationsLoading(),
      MoviesRecommendationsHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );

  blocTest<MoviesRecommendationsBloc, MoviesRecommendationsState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendations(1)),
    expect: () => [
      MoviesRecommendationsLoading(),
      const MoviesRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );
}
