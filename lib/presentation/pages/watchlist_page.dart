import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie/movie_bloc.dart';
import '../bloc/tvSeries/tv_series_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tvSeries';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistBloc>().add(FetchWatchlistMovies());
      context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistBloc>().add(FetchWatchlistMovies());
    context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Watchlist'),
            bottom: TabBar(tabs: [
              Tab(
                text: 'Movies',
              ),
              Tab(
                text: 'Tv Series',
              ),
            ]),
          ),
          body: TabBarView(children: [MovieWatchlist(), TvSeriesWatchlist()])),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class MovieWatchlist extends StatefulWidget {
  MovieWatchlist({Key? key}) : super(key: key);

  @override
  State<MovieWatchlist> createState() => _MovieWatchlistState();
}

class _MovieWatchlistState extends State<MovieWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, MovieStateBloc>(
            builder: (context, state) {
          if (state is MoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieState) {
            if (state.movies.length < 1) {
              return Center(
                child: Text('No movies added yet'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.movies[index];
                  return MovieCard(tvSeries);
                },
                itemCount: state.movies.length,
              );
            }
          } else if (state is MoviesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Text('can\'t load data');
          }
        }));
  }
}

class TvSeriesWatchlist extends StatefulWidget {
  TvSeriesWatchlist({Key? key}) : super(key: key);

  @override
  State<TvSeriesWatchlist> createState() => _TvSeriesWatchlistState();
}

class _TvSeriesWatchlistState extends State<TvSeriesWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, TvSeriesStateBloc>(
          builder: (context, state) {
            if (state is TvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvSeriesState) {
              if (state.tvSeries.length < 1) {
                return Center(
                  child: Text('No movies added yet'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.tvSeries[index];
                    return TvSeriesCard(tvSeries);
                  },
                  itemCount: state.tvSeries.length,
                );
              }
            } else if (state is TvSeriesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Text('can\'t load data');
            }
          },
        ));
  }
}
