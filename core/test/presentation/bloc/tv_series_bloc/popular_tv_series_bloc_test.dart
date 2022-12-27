import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:core/presentation/bloc/tv_series/popular_tv/popular_tv_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(
    () {
      mockGetPopularTv = MockGetPopularTv();
      popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTv);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      const PopularTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
