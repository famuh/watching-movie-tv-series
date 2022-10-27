import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(FetchDetailTvSeries(widget.id));
      context
          .read<TvSeriesRecommendationBloc>()
          .add(FetchTvSeriesRecommendation(widget.id));
      context
          .read<WatchlistTvSeriesBloc>()
          .add(WatchlistTvSeriesStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final tvSeriesRecommendation =
        context.select<TvSeriesRecommendationBloc, List<TvSeries>>((value) {
      var state = value.state;
      if (state is TvSeriesHasData) {
        return (state).tvSeries;
      }
      return [];
    });

    final isAddedToWatchlist =
        context.select<WatchlistTvSeriesBloc, bool>((val) {
      var state = val.state;
      if (state is WatchlistTvSeriesStatusState) {
        return state.status;
      }
      return false;
    });
    return Scaffold(body: BlocBuilder<TvSeriesDetailBloc, TvSeriesStateBloc>(
      builder: (context, state) {
        if (state is TvSeriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TvSeriesDetailState) {
          return SafeArea(
            child: DetailContent(
              state.tvSeries,
              tvSeriesRecommendation,
              isAddedToWatchlist,
            ),
          );
        } else if (state is TvSeriesError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text('No Tv Series :('),
          );
        }
      },
    ));
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tvSeries, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvSeriesBloc>()
                                      .add(SaveWatchistTvSeriesEvent(tvSeries));
                                } else {
                                  context.read<WatchlistTvSeriesBloc>().add(
                                      RemoveWatchlistTvSeriesEvent(tvSeries));
                                }

                                String message = '';
                                final watchlistState =
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .state;

                                if (watchlistState is WatchlistTvSeriesState) {
                                  message = isAddedWatchlist
                                      ? WatchlistTvSeriesBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvSeriesBloc
                                          .watchlistRemoveSuccessMessage;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? WatchlistTvSeriesBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvSeriesBloc
                                          .watchlistRemoveSuccessMessage;

                                  if (message ==
                                          WatchlistTvSeriesBloc
                                              .watchlistAddSuccessMessage ||
                                      message ==
                                          WatchlistTvSeriesBloc
                                              .watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(message),
                                      duration: Duration(milliseconds: 500),
                                    ));
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .add(WatchlistTvSeriesStatus(
                                            tvSeries.id));
                                  }
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            // Text(
                            //   _showDuration(tvSeries.),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvSeries = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvSeriesDetailPage.ROUTE_NAME,
                                          arguments: tvSeries.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  // String _showDuration(int runtime) {
  //   final int hours = runtime ~/ 60;
  //   final int minutes = runtime % 60;

  //   if (hours > 0) {
  //     return '${hours}h ${minutes}m';
  //   } else {
  //     return '${minutes}m';
  //   }
  // }
}
