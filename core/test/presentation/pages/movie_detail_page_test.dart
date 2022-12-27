import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_recommendations/movies_recommendations_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_status/watchlist_movie_status_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMoviesRecommendationsBloc
    extends MockBloc<MoviesRecommendationsEvent, MoviesRecommendationsState>
    implements MoviesRecommendationsBloc {}

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class MockWatchlistMovieStatusBloc
    extends MockBloc<WatchlistMovieStatusEvent, WatchlistMovieStatusState>
    implements WatchlistMovieStatusBloc {}

class MockMovieDetailEvent extends Fake implements MovieDetailEvent {}

class MockWatchlistMovieStatusEvent extends Fake
    implements WatchlistMovieStatusEvent {}

class MockMoviesRecommendationsEvent extends Fake
    implements MoviesRecommendationsEvent {}

class MockWatchlistMoviesEvent extends Fake implements WatchlistMoviesEvent {}

class MockMovieDetailState extends Fake implements MovieDetailState {}

class MockWatchlistMovieStatusState extends Fake
    implements WatchlistMovieStatusState {}

class MockMoviesRecommendationsState extends Fake
    implements MoviesRecommendationsState {}

class MockWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMoviesRecommendationsBloc mockMoviesRecommendationsBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;
  late MockWatchlistMovieStatusBloc mockWatchlistMovieStatusBloc;

  setUpAll(() {
    registerFallbackValue(MockMovieDetailState());
    registerFallbackValue(MockMovieDetailEvent());
    registerFallbackValue(MockMoviesRecommendationsState());
    registerFallbackValue(MockMoviesRecommendationsEvent());
    registerFallbackValue(MockWatchlistMoviesState());
    registerFallbackValue(MockWatchlistMoviesEvent());
    registerFallbackValue(MockWatchlistMovieStatusState());
    registerFallbackValue(MockWatchlistMovieStatusEvent());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMoviesRecommendationsBloc = MockMoviesRecommendationsBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
    mockWatchlistMovieStatusBloc = MockWatchlistMovieStatusBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => mockMovieDetailBloc,
        ),
        BlocProvider<MoviesRecommendationsBloc>(
          create: (_) => mockMoviesRecommendationsBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => mockWatchlistMoviesBloc,
        ),
        BlocProvider<WatchlistMovieStatusBloc>(
          create: (_) => mockWatchlistMovieStatusBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockMovieDetailBloc.close();
    mockMoviesRecommendationsBloc.close();
    mockWatchlistMoviesBloc.close();
    mockWatchlistMovieStatusBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockMoviesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenAnswer((_) => MoviesRecommendationsHasData([testMovie]));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMovieStatusBloc.state)
        .thenAnswer((_) => IsNotWatchlistMovies());
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => WatchlistMoviesInitial());

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockMoviesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenAnswer((_) => MoviesRecommendationsHasData([testMovie]));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMovieStatusBloc.state)
        .thenAnswer((_) => IsWatchlistMovies());
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => WatchlistMoviesInitial());

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockMoviesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenAnswer((_) => MoviesRecommendationsHasData([testMovie]));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMovieStatusBloc.state)
        .thenAnswer((_) => IsNotWatchlistMovies());
    when(() => mockWatchlistMoviesBloc.add(AddWatchlist(testMovieDetail)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => WatchlistMoviesInitial());
    whenListen(
        mockWatchlistMoviesBloc,
        Stream.fromIterable(
            [const WatchlistMoviesAdded('Added to Watchlist')]));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockMoviesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => MovieDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenAnswer((_) => MoviesRecommendationsHasData([testMovie]));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMovieStatusBloc.state)
        .thenAnswer((_) => IsNotWatchlistMovies());
    when(() => mockWatchlistMoviesBloc.add(AddWatchlist(testMovieDetail)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => WatchlistMoviesInitial());
    whenListen(mockWatchlistMoviesBloc,
        Stream.fromIterable([const WatchlistMoviesError('Failed')]));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
