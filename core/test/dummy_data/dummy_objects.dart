import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_series/tv_series_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv_series/tv_detail.dart';
import 'package:core/domain/entities/tv_series/tvseries.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTv = TvSeries(
  backdropPath: "/iHSwvRVsRyxpX7FE7GbviaDvgGZ.jpg",
  firstAirDate: "2022-11-23",
  genreIds: const [10765, 9648, 35],
  id: 119051,
  name: "Wednesday",
  originCountry: const ["US"],
  originalLanguage: "en",
  originalName: "Wednesday",
  overview:
      "Wednesday Addams is sent to Nevermore Academy, a bizarre boarding school where she attempts to master her psychic powers, stop a monstrous killing spree of the town citizens, and solve the supernatural mystery that affected her family 25 years ago — all while navigating her new relationships.",
  popularity: 4138.512,
  posterPath: "/9PFonBhy4cQy7Jz20NpMygczOkv.jpg",
  voteAverage: 8.8,
  voteCount: 3409,
);

final testMovieList = [testMovie];
final testTvList = [testTv];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: "backdropPath",
  firstAirDate: "2022-09-10",
  genres: [Genre(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  lastAirDate: '2021-08-13',
  name: 'name',
  numberOfEpisode: 1,
  numberOfSeason: 1,
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 5.5,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = const MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testWatchlistTv = TvSeries.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvTable = const TvSeriesTable(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
