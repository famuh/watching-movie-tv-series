import 'package:ditonton/data/models/tv%20series/tv_series_model.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      firstAirDate: '2020-05-05',
      genreIds: [1, 2],
      id: 1,
      title: 'Title',
      originCountry: ["US"],
      originalName: 'originalName',
      overview: 'Overview',
      popularity: 1,
      voteAverage: 1,
      voteCount: 1);

  final tTvSeries = TvSeries(
      firstAirDate: '2020-05-05',
      genreIds: [1, 2],
      id: 1,
      title: 'Title',
      originCountry: ["US"],
      originalName: 'originalName',
      overview: 'Overview',
      popularity: 1,
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of Movie entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
