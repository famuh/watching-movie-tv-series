import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/movie_search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series_now_playing.dart';
import 'package:ditonton/presentation/pages/tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'presentation/bloc/movie/movie_bloc.dart';
import 'presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'presentation/pages/top_rated_tv_series_page.dart';
import 'presentation/pages/tv_series_detail_page.dart';
import 'presentation/provider/tv series/now_playing_tv_series_notifier.dart';
import 'presentation/provider/tv series/popular_tv_series_notifier.dart';
import 'presentation/provider/tv series/top_rated_tv_series_notifier.dart';
import 'presentation/provider/tv series/tv_series_detail_notifier.dart';
import 'presentation/provider/tv series/tv_series_list_notifier.dart';
import 'presentation/provider/tv series/tv_series_search_notifier.dart';
import 'presentation/provider/tv series/watchlist_tv_series_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        // BLOC
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistBloc>()),

        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),

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

        // TV SERIES
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvSeriesListNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        // ),
        BlocProvider(create: (_) => di.locator<PopularTvSeriesBloc>()),

        BlocProvider(create: (_) => di.locator<TvSeriesDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvSeriesBloc>()),

        BlocProvider(create: (_) => di.locator<TopRatedTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvSeriesBloc>()),

        BlocProvider(create: (_) => di.locator<NowPlayingTvSeriesBloc>()),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvSeriesSearchNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<PopularTvSeriesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvSeriesDetailNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<NowPlayingTvSeriesNotifier>(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: MoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/movie':
              return MaterialPageRoute(builder: (_) => MoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchPageTvSeries.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTvSeries());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case NowPlayingTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => NowPlayingTvSeriesPage());
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
