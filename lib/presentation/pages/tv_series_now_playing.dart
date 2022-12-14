import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';

  @override
  _NowPlayingTvSeriesPageState createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingTvSeriesBloc>().add(FetchNowPlayingTvSeries())
  );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, TvSeriesStateBloc>(
            builder: (context, state) {
              if (state is TvSeriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvSeriesHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.tvSeries[index];
                    return TvSeriesCard(movie);
                  },
                  itemCount: state.tvSeries.length,
                );
              } else if (state is TvSeriesError) {
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
