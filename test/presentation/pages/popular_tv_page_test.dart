
import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_series_bloc.dart';

void main() {
  late PopularTvSeriesBlocHelper popularTvBlocHelper;
  setUpAll(() {
    popularTvBlocHelper = PopularTvSeriesBlocHelper();
    registerFallbackValue(PopularTvSeriesStateHelper());
    registerFallbackValue(PopularTvSeriesEventBlocHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>(
      create: (_) => popularTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularTvBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvSeriesLoading());
    when(() => popularTvBlocHelper.state).thenReturn(TvSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  
}
