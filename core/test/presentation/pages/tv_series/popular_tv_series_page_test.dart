import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv_series/popular_tv/popular_tv_series_bloc.dart';
import 'package:core/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopularTvSeriesBloc
    extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

class MockPopularTvSeriesEvent extends Fake implements PopularTvSeriesEvent {}

class MockPopularTvSeriesState extends Fake implements PopularTvSeriesState {}

void main() {
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(MockPopularTvSeriesState());
    registerFallbackValue(MockPopularTvSeriesEvent());
  });

  setUp(() {
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>.value(
      value: mockPopularTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state)
        .thenAnswer((_) => PopularTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state)
        .thenAnswer((_) => PopularTvSeriesLoading());
    when(() => mockPopularTvSeriesBloc.state)
        .thenAnswer((_) => PopularTvSeriesHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state)
        .thenAnswer((_) => PopularTvSeriesLoading());
    when(() => mockPopularTvSeriesBloc.state)
        .thenAnswer((_) => const PopularTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
