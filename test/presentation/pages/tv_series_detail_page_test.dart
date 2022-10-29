
import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_series_bloc.dart';


void main() {
  late TvSeriesDetailBlocHelper tvDetailBlocHelper;
  late TvSeriesRecommendationBlocHelper recommendationsTvBlocHelper;
  late WatchlistTvSeriesBlocHelper watchlistTvBlocHelper;

  setUpAll(() {
    tvDetailBlocHelper = TvSeriesDetailBlocHelper();
    registerFallbackValue(TvSeriesDetailEventHelper());
    registerFallbackValue(TvSeriesDetailStateHelper());

    recommendationsTvBlocHelper = TvSeriesRecommendationBlocHelper();
    registerFallbackValue(TvSeriesRecommendationEventBlocHelper());
    registerFallbackValue(TvSeriesRecommendationStateHelper());

    watchlistTvBlocHelper = WatchlistTvSeriesBlocHelper();
    registerFallbackValue(WatchlistTvSeriesEventBlocHelper());
    registerFallbackValue(WatchlistTvSeriesStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(create: (_) => tvDetailBlocHelper),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (_) => watchlistTvBlocHelper,
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (_) => recommendationsTvBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => tvDetailBlocHelper.state).thenReturn(TvSeriesLoading());
        when(() => watchlistTvBlocHelper.state).thenReturn(TvSeriesLoading());
        when(() => recommendationsTvBlocHelper.state).thenReturn(TvSeriesLoading());

        final circularProgress = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
          id: 1,
        )));
        await tester.pump();

        expect(circularProgress, findsOneWidget);
      });
  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
          (WidgetTester tester) async {
        when(() => tvDetailBlocHelper.state)
            .thenReturn(TvSeriesDetailState(testTvSeriesDetail));
        when(() => recommendationsTvBlocHelper.state)
            .thenReturn(TvSeriesHasData(testTvSeriesList));
        when(() => watchlistTvBlocHelper.state)
            .thenReturn(WatchlistTvSeriesStatusState(false));

        final watchListButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget( TvSeriesDetailPage(id: 97080)));
        await tester.pump();
        expect(watchListButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
          (WidgetTester tester) async {
        when(() => tvDetailBlocHelper.state)
            .thenReturn(TvSeriesDetailState(testTvSeriesDetail));

        when(() => recommendationsTvBlocHelper.state)
            .thenReturn(TvSeriesHasData(testTvSeriesList));
        when(() => watchlistTvBlocHelper.state)
            .thenReturn(WatchlistTvSeriesStatusState(true));

        final watchListButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget( TvSeriesDetailPage(id: 97080)));
        expect(watchListButtonIcon, findsOneWidget);
      });
}
