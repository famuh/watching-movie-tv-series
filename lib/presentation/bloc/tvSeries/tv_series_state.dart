part of 'tv_series_bloc.dart';

abstract class TvSeriesStateBloc extends Equatable {
  const TvSeriesStateBloc();
  
  @override
  List<Object> get props => [];
}

class TvSeriesLoading extends TvSeriesStateBloc {}

class TvSeriesEmpty extends TvSeriesStateBloc {}

class TvSeriesHasData extends TvSeriesStateBloc {
  final List<TvSeries> tvSeries;

  const TvSeriesHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesError extends TvSeriesStateBloc {
  final String message;

  const TvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailState extends TvSeriesStateBloc{
  final TvSeriesDetail tvSeries;

  TvSeriesDetailState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class WatchlistTvSeriesState extends TvSeriesStateBloc{
  final List<TvSeries> tvSeries;

  WatchlistTvSeriesState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class WatchlistTvSeriesMessage extends TvSeriesStateBloc{
  final String message;
  const WatchlistTvSeriesMessage(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesStatusState extends TvSeriesStateBloc {
  final bool status;

  const WatchlistTvSeriesStatusState(this.status);

  @override
  List<Object> get props => [status];
}

// SEARCH MOVIE
class SearchStateTvSeries extends Equatable {
  const SearchStateTvSeries();
  
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchStateTvSeries {}

class SearchLoading extends SearchStateTvSeries {}

class SearchError extends SearchStateTvSeries {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvSeriesHasData extends SearchStateTvSeries {
  final List<TvSeries> result;

  SearchTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];

}

class TvSeriesDetailDataState extends SearchStateTvSeries{
  final TvSeriesDetail tvSeries;

  TvSeriesDetailDataState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}