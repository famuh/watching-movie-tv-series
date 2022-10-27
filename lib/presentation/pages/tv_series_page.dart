import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_now_playing.dart';
import 'package:ditonton/presentation/pages/tv_series_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../provider/tv series/tv_series_list_notifier.dart';
import 'about_page.dart';
import 'tv_series_detail_page.dart';
import 'watchlist_page.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<NowPlayingTvSeriesBloc>().add(FetchNowPlayingTvSeries());
      context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries());
      context.read<TopRatedTvSeriesBloc>().add(FetchTopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, MoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.live_tv_rounded),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTvSeries.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOW PLAYING
                 _buildSubHeading(
                  title: 'Now Playing',
                  onTap: () => Navigator.pushNamed(
                      context, NowPlayingTvSeriesPage.ROUTE_NAME),
                ),

                BlocBuilder<NowPlayingTvSeriesBloc, TvSeriesStateBloc>(
                builder: (context, state) {
                  if (state is TvSeriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }else if(state is TvSeriesHasData){
                    return TvSeriesList(state.tvSeries);
                  }else if(state is TvSeriesError){
                    return Center(child: Text(state.message),);
                  }else{
                    return Center(child: Text('No Movies :('),);
                  }
                },
              )
                // Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                //   final state = data.nowPlayingState;
                //   if (state == RequestState.Loading) {
                //     return Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   } else if (state == RequestState.Loaded) {
                //     return TvSeriesList(data.nowPlayingTvSeries);
                //   } else {
                //     return Text('Failed');
                //   }
                // }),
,
                // POPULAR
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () => Navigator.pushNamed(
                      context, PopularTvSeriesPage.ROUTE_NAME),
                ),
                BlocBuilder<PopularTvSeriesBloc, TvSeriesStateBloc>(
                builder: (context, state) {
                  if (state is TvSeriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }else if(state is TvSeriesHasData){
                    return TvSeriesList(state.tvSeries);
                  }else if(state is TvSeriesError){
                    return Center(child: Text(state.message),);
                  }else{
                    return Center(child: Text('No Movies :('),);
                  }
                },
              ),
                // Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                //   final state = data.popularTvSeriesState;
                //   if (state == RequestState.Loading) {
                //     return Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   } else if (state == RequestState.Loaded) {
                //     return TvSeriesList(data.popularTvSeries);
                //   } else {
                //     return Text('Failed');
                //   }
                // }),

                // TOP RATED
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () => Navigator.pushNamed(
                      context, TopRatedTvSeriesPage.ROUTE_NAME),
                ),
                BlocBuilder<TopRatedTvSeriesBloc, TvSeriesStateBloc>(
                builder: (context, state) {
                  if (state is TvSeriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }else if(state is TvSeriesHasData){
                    return TvSeriesList(state.tvSeries);
                  }else if(state is TvSeriesError){
                    return Center(child: Text(state.message),);
                  }else{
                    return Center(child: Text('No Movies :('),);
                  }
                },
              ),
                
                // Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                //   final state = data.topRatedTvSeriesState;
                //   if (state == RequestState.Loading) {
                //     return Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   } else if (state == RequestState.Loaded) {
                //     return TvSeriesList(data.topRatedTvSeries);
                //   } else {
                //     return Text('Failed');
                //   }
                // }),
              ],
            ),
          )),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSerieses;

  TvSeriesList(this.tvSerieses);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSerieses[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.backdropPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSerieses.length,
      ),
    );
  }
}
