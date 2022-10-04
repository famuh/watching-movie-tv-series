

import 'package:equatable/equatable.dart';

class TvSeries extends Equatable{
  TvSeries({
    this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originCountry,
    // required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  TvSeries.watchList({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });
  String?backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? title;
  List? originCountry;
  // OriginalLanguage originalLanguage;
  String? originalName;
  String overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        title, 
        originCountry,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}


