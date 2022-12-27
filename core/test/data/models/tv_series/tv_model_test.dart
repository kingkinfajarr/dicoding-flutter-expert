import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: "backdropPath",
    firstAirDate: "firstAirDate",
    genreIds: [1, 2, 3],
    id: 500,
    name: "name",
    originCountry: ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 7.5,
    posterPath: "posterPath",
    voteAverage: 7.0,
    voteCount: 1000,
  );

  final tTv = TvSeries(
    backdropPath: "backdropPath",
    firstAirDate: "firstAirDate",
    genreIds: const [1, 2, 3],
    id: 500,
    name: "name",
    originCountry: const ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 7.5,
    posterPath: "posterPath",
    voteAverage: 7.0,
    voteCount: 1000,
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
