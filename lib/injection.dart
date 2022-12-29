import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/tv_database_helper.dart';
import 'package:core/data/datasources/http_ssl_pinning.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series/tv_series_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_series/search_tv.dart';
import 'package:core/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_recommendations/movies_recommendations_bloc.dart';
import 'package:core/presentation/bloc/movie/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/search_movie/search_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_status/watchlist_movie_status_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movies_data/watchlist_movies_data_bloc.dart';
import 'package:core/presentation/bloc/tv_series/now_playing_tv/airing_today_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/popular_tv/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/search_tv/tv_series_search_bloc.dart';
import 'package:core/presentation/bloc/tv_series/top_rated_tv/top_rated_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_detail/tv_series_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_recommendations/tv_series_recommendations_bloc.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv_data/watchlist_tv_series_data_bloc.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv_status/watchlist_tv_series_status_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieStatusBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesDataBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => AiringTodayTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesBloc(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesStatusBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesDataBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv series
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // repository tv series
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data source tv series
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
