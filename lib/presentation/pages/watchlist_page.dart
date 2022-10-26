import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/movie/movie_bloc.dart';
import '../provider/tv series/watchlist_tv_series_notifier.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
        // Provider.of<WatchlistMovieNotifier>(context, listen: false)
        //     .fetchWatchlistMovies());
    context.read<WatchlistBloc>().add(FetchWatchlistMovies());

    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
        context.read<WatchlistBloc>().add(FetchWatchlistMovies());

    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
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
          } else if (state is WatchlistMovieState){
            if (state.movies.length < 1) {
              return Center(
                child:Text('No movies added yet') ,
              );
            }else{
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            }
          } else if (state is MoviesError){
            return Center(
              child: Text(state.message),
            );
        }else{
            return Text('can\'t load data');
        }
        }
      )
      // Consumer<WatchlistMovieNotifier>(
      //   builder: (context, data, child) {
      //     if (data.watchlistState == RequestState.Loading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (data.watchlistState == RequestState.Loaded) {
      //       if (data.watchlistMovies.length < 1) {
      //         return Center(
      //           child: Text('No movies added yet'),
      //         );
      //       } else {
      //         return ListView.builder(
      //           itemBuilder: (context, index) {
      //             final movie = data.watchlistMovies[index];
      //             return MovieCard(movie);
      //           },
      //           itemCount: data.watchlistMovies.length,
      //         );
      //       }
      //     } else {
      //       return Center(
      //         key: Key('error_message'),
      //         child: Text(data.message),
      //       );
      //     }
      //   },
      // ),
    
    );
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
      child: Consumer<WatchlistTvSeriesNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            if (data.watchlistTvSeries.length < 1) {
              return Center(
                child: Text('No tv series added yet'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.watchlistTvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.watchlistTvSeries.length,
              );
            }
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
