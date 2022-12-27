import 'package:about/about_page.dart';
import 'package:core/common/utils.dart';
import 'package:core/core.dart';
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
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_series/home_tvseries_page.dart';
import 'package:core/presentation/pages/tv_series/now_playing_tv_page.dart';
import 'package:core/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:core/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:core/presentation/pages/tv_series/tv_detail_page.dart';
import 'package:core/presentation/pages/tv_series/tv_search_page.dart';
import 'package:core/presentation/pages/tv_series/watchlist_tv_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieListNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieDetailNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieSearchNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TopRatedMoviesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<PopularMoviesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<WatchlistMovieNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvListNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvDetailNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvSearchNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<NowPlayingTvNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<PopularTvNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TopRatedTvNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<WatchlistTvNotifier>(),
        // ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesDataBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),

        // TV
        BlocProvider(
          create: (_) => di.locator<AiringTodayTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesDataBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case NowPlayingTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingTvPage());
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case TvSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
