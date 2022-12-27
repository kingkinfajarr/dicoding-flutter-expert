import 'dart:convert';

import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:core/data/models/tv_series/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  // ignore: prefer_const_constructors
  final tTvModel = TvModel(
    backdropPath: "/path.jpg",
    firstAirDate: "2021-08-03",
    genreIds: const [1, 2, 3, 4],
    id: 130542,
    name: "Name",
    originCountry: const ["IN"],
    originalLanguage: "en",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1526.28,
    posterPath: "/path.jpg",
    voteAverage: 3.0,
    voteCount: 6,
  );

  final tTvResponseModel = TvSeriesResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/now_playing.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2021-08-03",
            "genre_ids": [1, 2, 3, 4],
            "id": 130542,
            "name": "Name",
            "origin_country": ["IN"],
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1526.28,
            "poster_path": "/path.jpg",
            "vote_average": 3.0,
            "vote_count": 6
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
