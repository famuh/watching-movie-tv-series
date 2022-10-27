import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvSeriesBloc>().add(FetchTopRatedTvSeries())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TvSeriesStateBloc>(
            builder: (context, state) {
              if (state is TvSeriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvSeriesHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.tvSeries[index];
                    return TvSeriesCard(tvSeries);
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
            }
      ),
    ));
  }
}
