import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/presentation/bloc/tv_series/now_playing_tv/airing_today_tv_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late AiringTodayTvSeriesBloc airingTodayTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetAiringTodaySeries;

  setUp(
    () {
      mockGetAiringTodaySeries = MockGetNowPlayingTvSeries();
      airingTodayTvSeriesBloc =
          AiringTodayTvSeriesBloc(mockGetAiringTodaySeries);
    },
  );

  final tSeries = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
  );

  final tSeriesList = <TvSeries>[tSeries];

  test(
    'initial state should be empty',
    () {
      expect(airingTodayTvSeriesBloc.state, AiringTodayTvSeriesEmpty());
    },
  );

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return airingTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodaySeries()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      AiringTodayTvSeriesHasData(tSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodaySeries.execute());
    },
  );

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return airingTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodaySeries()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      const AiringTodayTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodaySeries.execute());
    },
  );
}
