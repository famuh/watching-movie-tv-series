import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,

    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,

    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List<dynamic> episodeRunTime;
  final DateTime firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final String name;

  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;

  final List<Season> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],

        episodeRunTime:
            List<dynamic>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        "name": name,

        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,

        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),

        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genreIds: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        title: this.name,
        originCountry: this.originCountry,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,

        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,

        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class Season {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final DateTime airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
}
