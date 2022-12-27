import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/search_tv.dart';
import 'package:core/presentation/bloc/tv_series/search_tv/tv_series_search_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTv mockSearchSeries;

  setUp(
    () {
      mockSearchSeries = MockSearchTv();
      tvSeriesSearchBloc = TvSeriesSearchBloc(mockSearchSeries);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(tvSeriesSearchBloc.state, TvSeriesSearchEmpty());
    },
  );

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchSeries.execute('chucky'))
          .thenAnswer((_) async => Right(testTvList));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(FetchSeriesSearch('chucky')),
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute('chucky'));
    },
  );

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockSearchSeries.execute('chucky'))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(FetchSeriesSearch('chucky')),
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute('chucky'));
    },
  );
}
