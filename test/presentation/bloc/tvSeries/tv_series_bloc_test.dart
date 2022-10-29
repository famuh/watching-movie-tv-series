import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv%20series/tv_series_model.dart';
import 'package:ditonton/domain/entities/tvSeries.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv%20series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv%20series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv%20series/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/tv%20series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv%20series/get_tv_series_reccomendations.dart';
import 'package:ditonton/domain/usecases/tv%20series/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv%20series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv%20series/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tvSeries/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_bloc_test.mocks.dart';


@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetNowPlayingTvSeries,
  GetTopRatedTvSeries,
  GetPopularTvSeries,
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  RemoveWatchlistTvSeries,
  SaveWatchlistTvSeries,
])
void main() {
  late NowPlayingTvSeriesBloc onTheAirNowBloc;
  late PopularTvSeriesBloc popularTvBloc;
  late TopRatedTvSeriesBloc topRatedTvBloc;
  late TvSeriesDetailBloc detailTvBloc;
  late TvSeriesRecommendationBloc recommendationTvBloc;
  late WatchlistTvSeriesBloc watchlistTvBloc;

  late MockGetTvSeriesDetail mockGetTvDetail;
  late MockGetTvSeriesRecommendations mockGetTvRecomendation;
  late MockGetNowPlayingTvSeries mockGetOnTheAirTv;
  late MockGetTopRatedTvSeries mockGetTopRatedTv;
  late MockGetPopularTvSeries mockGetPopularTv;
  late MockGetWatchlistTvSeries mockGetWatchListTv;
  late MockGetWatchListStatusTvSeries mockGetWatchListTvStatus;
  late MockRemoveWatchlistTvSeries mockRemoveTvWatchlist;
  late MockSaveWatchlistTvSeries mockSaveTvWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvSeriesDetail();
    mockGetTvRecomendation = MockGetTvSeriesRecommendations();
    mockGetOnTheAirTv = MockGetNowPlayingTvSeries();
    mockGetTopRatedTv = MockGetTopRatedTvSeries();
    mockGetPopularTv = MockGetPopularTvSeries();
    mockGetWatchListTv = MockGetWatchlistTvSeries();
    mockGetWatchListTvStatus = MockGetWatchListStatusTvSeries();
    mockRemoveTvWatchlist = MockRemoveWatchlistTvSeries();
    mockSaveTvWatchlist = MockSaveWatchlistTvSeries();

    onTheAirNowBloc = NowPlayingTvSeriesBloc(mockGetOnTheAirTv);
    popularTvBloc = PopularTvSeriesBloc(mockGetPopularTv);
    topRatedTvBloc = TopRatedTvSeriesBloc(mockGetTopRatedTv);

    watchlistTvBloc = WatchlistTvSeriesBloc(
      mockGetWatchListTv,
      mockGetWatchListTvStatus,
      mockSaveTvWatchlist,
      mockRemoveTvWatchlist,
    );
    recommendationTvBloc = TvSeriesRecommendationBloc(mockGetTvRecomendation);
    detailTvBloc = TvSeriesDetailBloc(
      mockGetTvDetail,
    );
  });
  final tTvModel = TvSeriesModel(
    backdropPath: '/backdropPath',
    firstAirDate: '2021-01-01',
    genreIds: const [1, 2],
    id: 1,
    name: 'name',
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTv = TvSeries(
    backdropPath: '/backdropPath',
    firstAirDate: '2021-01-01',
    genreIds: const [1, 2],
    id: 1,
    name: 'name',
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <TvSeries>[tTv];
  final tId = 1;
  final tQuery = "chainsaw";

  group('Get now playing movies', () {
    test('initial state must be empty', () {
      expect(onTheAirNowBloc.state, TvSeriesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return onTheAirNowBloc;
      },
      act: (NowPlayingTvSeriesBloc bloc) => bloc.add(FetchNowPlayingTvSeries()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvSeriesLoading(), TvSeriesHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return onTheAirNowBloc;
      },
      act: (NowPlayingTvSeriesBloc bloc) => bloc.add(FetchNowPlayingTvSeries()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvSeriesLoading(),
        TvSeriesError('Server Failure'),
      ],
      verify: (NowPlayingTvSeriesBloc bloc) => verify(mockGetOnTheAirTv.execute()),
    );
  });

  group('Get Popular movies', () {
    test('initial state must be empty', () {
      expect(popularTvBloc.state, TvSeriesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (PopularTvSeriesBloc bloc) => bloc.add(FetchPopularTvSeries()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvSeriesLoading(), TvSeriesHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (PopularTvSeriesBloc bloc) => bloc.add(FetchPopularTvSeries()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularTv.execute()),
    );
  });

  group('Get Top Rated movies', () {
    test('initial state must be empty', () {
      expect(topRatedTvBloc.state, TvSeriesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      act: (TopRatedTvSeriesBloc bloc) => bloc.add(FetchTopRatedTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvSeriesLoading(), TvSeriesHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (TopRatedTvSeriesBloc bloc) => bloc.add(FetchTopRatedTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedTv.execute()),
    );
  });

  group('Get Recommended movies', () {
    test('initial state must be empty', () {
      expect(recommendationTvBloc.state, TvSeriesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvRecomendation.execute(tId))
            .thenAnswer((_) async => Right(tTvList));
        return recommendationTvBloc;
      },
      act: (TvSeriesRecommendationBloc bloc) => bloc.add(FetchTvSeriesRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvSeriesLoading(), TvSeriesHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecomendation.execute(tId)).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return recommendationTvBloc;
      },
      act: (TvSeriesRecommendationBloc bloc) => bloc.add(FetchTvSeriesRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvRecomendation.execute(tId)),
    );
  });

  group('Get Details movies', () {
    test('initial state must be empty', () {
      expect(detailTvBloc.state, TvSeriesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return detailTvBloc;
      },
      act: (TvSeriesDetailBloc bloc) => bloc.add(FetchDetailTvSeries(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvSeriesLoading(), TvSeriesDetailState(testTvSeriesDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (TvSeriesDetailBloc bloc) => bloc.add(FetchDetailTvSeries(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSeriesLoading(),
        const TvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvDetail.execute(tId)),
    );
  });

  group('Get Watchlist movies', () {
    test('initial state must be empty', () {
      expect(watchlistTvBloc.state, TvSeriesEmpty());
    });

    group('Watchlist Movie', () {
      test('initial state should be empty', () {
        expect(watchlistTvBloc.state, TvSeriesEmpty());
      });

      group('Fetch Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListTv.execute())
                .thenAnswer((_) async => Right(tTvList));
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) => bloc.add(FetchWatchlistTvSeries()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            WatchlistTvSeriesState(tTvList),
          ],
          verify: (bloc) => verify(mockGetWatchListTv.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListTv.execute())
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) => bloc.add(FetchWatchlistTvSeries()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            const TvSeriesError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchListTv.execute()),
        );
      });

      group('Load Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListTvStatus.execute(tId))
                .thenAnswer((_) async => true);
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) => bloc.add(WatchlistTvSeriesStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            WatchlistTvSeriesStatusState(true),
          ],
          verify: (bloc) => verify(mockGetWatchListTvStatus.execute(tId)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListTvStatus.execute(tId))
                .thenAnswer((_) async => false);
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) => bloc.add(WatchlistTvSeriesStatus(tId)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            WatchlistTvSeriesStatusState(false),
          ],
          verify: (bloc) => verify(mockGetWatchListTvStatus.execute(tId)),
        );
      });

      group('Save Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveTvWatchlist.execute(testTvSeriesDetail)).thenAnswer(
                    (_) async => Right(WatchlistTvSeriesBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) =>
              bloc.add(SaveWatchistTvSeriesEvent(testTvSeriesDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            WatchlistTvSeriesMessage(WatchlistTvSeriesBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockSaveTvWatchlist.execute(testTvSeriesDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSaveTvWatchlist.execute(testTvSeriesDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) =>
              bloc.add(SaveWatchistTvSeriesEvent(testTvSeriesDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            TvSeriesError('Server Failure'),
          ],
          verify: (bloc) => verify(mockSaveTvWatchlist.execute(testTvSeriesDetail)),
        );
      });

      group('Remove Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveTvWatchlist.execute(testTvSeriesDetail)).thenAnswer(
                    (_) async => Right(WatchlistTvSeriesBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) =>
              bloc.add(RemoveWatchlistTvSeriesEvent(testTvSeriesDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            WatchlistTvSeriesMessage(WatchlistTvSeriesBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockRemoveTvWatchlist.execute(testTvSeriesDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockRemoveTvWatchlist.execute(testTvSeriesDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvSeriesBloc bloc) =>
              bloc.add(RemoveWatchlistTvSeriesEvent(testTvSeriesDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvSeriesLoading(),
            TvSeriesError('Server Failure'),
          ],
          verify: (bloc) => verify(mockRemoveTvWatchlist.execute(testTvSeriesDetail)),
        );
      });

    });
  });
}
