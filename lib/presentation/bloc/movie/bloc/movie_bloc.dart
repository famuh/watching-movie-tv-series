import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_watchlist_status.dart';
import '../../../../domain/usecases/movie/get_movie_detail.dart';
import '../../../../domain/usecases/movie/get_watchlist_movies.dart';
import '../../../../domain/usecases/movie/remove_watchlist.dart';
import '../../../../domain/usecases/movie/save_watchlist.dart';

part 'movie_event.dart';
part 'movie_state.dart';

// class MovieBloc extends Bloc<MovieEvent, MovieState> {
//   MovieBloc() : super(MovieInitial()) {
//     on<MovieEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

class MovieDetailBloc extends Bloc<MovieEventBloc, MovieStateBloc> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MoviesLoading()) {
    on<FetchDetailMovie>((event, emit) async {
      final id = event.id;

      emit(MoviesLoading());

      final result = await _getMovieDetail.execute(id);
      result.fold(
        (failure) {
        emit(MoviesError(failure.message));
      }, (data) {
        emit(MovieDetailState(data));
      });
    });
  }
}

class MovieRecommendationBloc extends Bloc<MovieEventBloc, MovieStateBloc>{
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationBloc(this._getMovieRecommendations) : super(MoviesLoading()){
    on<FetchMovieRecommendation>((event, emit) async {
      
      final int id = event.id;
      emit(MoviesLoading());

      final result = await _getMovieRecommendations.execute(id);
      result.fold(
        (failure){
        emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        });
    });
  }
}


class WatchlistBloc extends Bloc<MovieEventBloc, MovieStateBloc> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MoviesEmpty()) {
    on<FetchWatchlistMovies>(
          (event, emit) async {
        emit(MoviesLoading());

        final result = await _getWatchlistMovies.execute();
        result.fold((failure) {
          emit(
            MoviesError(failure.message));
        }, (data) {
          emit(WatchlistMovieState(data));
        });
      },
    );

    on<SaveWatchistMovie>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _saveWatchlist.execute(movie);

      result.fold((failure) => emit(MoviesError(failure.message)),
              (data) => emit(WatchlistMovieMessage(data)));
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _removeWatchlist.execute(movie);

      result.fold((failure) => emit(MoviesError(failure.message)),
              (data) => emit(WatchlistMovieMessage(data)));
    });

    on<WatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MoviesLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(WatchlistMovieStatusState(result));
    });
  }
}

