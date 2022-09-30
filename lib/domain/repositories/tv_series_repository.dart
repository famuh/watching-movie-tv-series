import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();

  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);


  Future<Either<Failure, String>> saveWatchlistTvSeries(TvSeriesDetail tvSeriesDetail);
  Future<Either<Failure, String>> removeWatchlistTvSeries(TvSeriesDetail tvSeries);



}
