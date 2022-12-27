import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/search_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTv(mockTvSeriesRepository);
  });

  final tTv = <TvSeries>[];
  const tQuery = 'Wednesday';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
