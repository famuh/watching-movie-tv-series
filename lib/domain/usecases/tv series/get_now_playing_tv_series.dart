import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}
