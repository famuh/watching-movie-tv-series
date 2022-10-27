import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../provider/tv series/popular_tv_series_notifier.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        // Provider.of<PopularTvSeriesNotifier>(context, listen: false).fetchPopularTvSeries());
        context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, TvSeriesStateBloc>(
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


        // Consumer<PopularTvSeriesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.state == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final tvSeries = data.tvSeries[index];
        //           return TvSeriesCard(tvSeries);
        //         },
        //         itemCount: data.tvSeries.length,
        //       );
        //     } else {
        //       return Center(
        //         key: Key('error_message'),
        //         child: Text(data.message),
        //       );
        //     }
        //   },
        // ),
      ),
    ));
  }
}
