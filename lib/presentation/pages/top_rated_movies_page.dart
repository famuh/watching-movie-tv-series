import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedMovieBloc>().add(FetchTopRatedMovies())
  );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:BlocBuilder<TopRatedMovieBloc, MovieStateBloc>(
            builder: (context, state) {
              if (state is MoviesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MoviesHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movie[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movie.length,
                );
              } else if (state is MoviesError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text('No Movies :('),
                );
              }
            },
          )
      ),
    );
  }
}
