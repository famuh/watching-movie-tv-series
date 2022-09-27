import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  // Future<String> insertWatchlist(TvSeriesTable tvSeries);
  // Future<String> removeWatchlist(MovieTable tvSeries);
  // Future<MovieTable?> getTvSeriesById(int id);
  // Future<List<MovieTable>> getWatchlistMovies();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  // @override
  // Future<String> insertWatchlist(TvSeriesTable movie) async {
  //   try {
  //     await databaseHelper.insertWatchlist(movie);
  //     return 'Added to Watchlist';
  //   } catch (e) {
  //     throw DatabaseException(e.toString());
  //   }
  // }

  // @override
  // Future<String> removeWatchlist(TvSeriesTable movie) async {
  //   try {
  //     await databaseHelper.removeWatchlist(movie);
  //     return 'Removed from Watchlist';
  //   } catch (e) {
  //     throw DatabaseException(e.toString());
  //   }
  // }

  // @override
  // Future<MovieTable?> getMovieById(int id) async {
  //   final result = await databaseHelper.getMovieById(id);
  //   if (result != null) {
  //     return MovieTable.fromMap(result);
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // Future<List<TvSeriesTable>> getWatchlistMovies() async {
  //   final result = await databaseHelper.getWatchlistMovies();
  //   return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  // }

}
