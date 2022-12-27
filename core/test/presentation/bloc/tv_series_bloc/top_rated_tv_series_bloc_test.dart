import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:core/presentation/bloc/tv_series/top_rated_tv/top_rated_tv_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTv mockGetTopRatedSeries;

  setUp(
    () {
      mockGetTopRatedSeries = MockGetTopRatedTv();
      topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedSeries);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      const TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );
}
