import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>>getTopRatedTvSeries ();

}
