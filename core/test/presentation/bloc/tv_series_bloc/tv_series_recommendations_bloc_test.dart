import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:core/presentation/bloc/tv_series/tv_recommendations/tv_series_recommendations_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvSeriesRecommendationsBloc tvSeriesRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvSeriesRecommendations;

  setUp(
    () {
      mockGetTvSeriesRecommendations = MockGetTvRecommendations();
      tvSeriesRecommendationsBloc =
          TvSeriesRecommendationsBloc(mockGetTvSeriesRecommendations);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(tvSeriesRecommendationsBloc.state, TvSeriesRecommendationsEmpty());
    },
  );

  blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTvList));
      return tvSeriesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendations(1)),
    expect: () => [
      TvSeriesRecommendationsLoading(),
      TvSeriesRecommendationsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );

  blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendations(1)),
    expect: () => [
      TvSeriesRecommendationsLoading(),
      const TvSeriesRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );
}
