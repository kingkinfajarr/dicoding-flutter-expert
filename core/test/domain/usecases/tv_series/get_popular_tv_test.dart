import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTv(mockTvSeriesRepository);
  });

  final tTv = <TvSeries>[];
  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSeriesRepository.getPopularTv())
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}
