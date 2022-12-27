import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvRecommendations(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTv = <TvSeries>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTv));
  });
}
