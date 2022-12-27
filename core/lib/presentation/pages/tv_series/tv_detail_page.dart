import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tv_series/tv_detail/tv_series_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_recommendations/tv_series_recommendations_bloc.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv_status/watchlist_tv_series_status_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core.dart';
import '../../../domain/entities/genre.dart';
import '../../../domain/entities/tv_series/tv_detail.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(FetchTvSeriesDetail(widget.id));
      // context.read<SelectedSeasonBloc>().add(SetSelectedSeasonEmpty());
      context
          .read<TvSeriesRecommendationsBloc>()
          .add(FetchRecommendations(widget.id));
      context
          .read<WatchlistTvSeriesStatusBloc>()
          .add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (contextDetail, stateDetail) {
          if (stateDetail is TvSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (stateDetail is TvSeriesDetailHasData) {
            final series = stateDetail.result;
            return SafeArea(
              child: DetailContent(
                series,
              ),
            );
          } else if (stateDetail is TvSeriesDetailError) {
            return Text(stateDetail.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;

  const DetailContent(this.tvDetail);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      listener: (contextListener, stateListener) {
        if (stateListener is WatchlistTvSeriesAdded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(stateListener.message)));
        } else if (stateListener is WatchlistTvSeriesRemoved) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(stateListener.message)));
        } else if (stateListener is WatchlistTvSeriesError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(stateListener.message),
                );
              });
        } else {
          const SizedBox();
        }
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
            width: screenWidth,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tvDetail.name,
                                style: kHeading5,
                              ),
                              BlocBuilder<WatchlistTvSeriesStatusBloc,
                                  WatchlistTvSeriesStatusState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      state is IsWatchlistTvSeries
                                          ? context
                                              .read<WatchlistTvSeriesBloc>()
                                              .add(
                                                  RemoveFromWatchlist(tvDetail))
                                          : context
                                              .read<WatchlistTvSeriesBloc>()
                                              .add(AddWatchlist(tvDetail));
                                      context
                                          .read<WatchlistTvSeriesStatusBloc>()
                                          .add(
                                              LoadWatchlistStatus(tvDetail.id));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state is IsWatchlistTvSeries
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Text(
                                _showGenres(tvDetail.genres),
                              ),
                              // Text(
                              //   _showDuration(movie.runtime),
                              // ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tvDetail.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${tvDetail.voteAverage}')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                tvDetail.overview,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              BlocBuilder<TvSeriesRecommendationsBloc,
                                  TvSeriesRecommendationsState>(
                                builder: (context, state) {
                                  if (state is TvSeriesRecommendationsLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is TvSeriesRecommendationsError) {
                                    return Text(state.message);
                                  } else if (state
                                      is TvSeriesRecommendationsHasData) {
                                    return SizedBox(
                                      height: 150,
                                      child: state.recommendations.isNotEmpty
                                          ? ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                final series = state
                                                    .recommendations[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                        context,
                                                        TvDetailPage.ROUTE_NAME,
                                                        arguments: series.id,
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(8),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://image.tmdb.org/t/p/w500${series.posterPath}',
                                                        placeholder:
                                                            (context, url) =>
                                                                const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount:
                                                  state.recommendations.length,
                                            )
                                          : const Text(
                                              'There is no recommendations'),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // initialChildSize: 0.5,
              minChildSize: 0.25,
              // maxChildSize: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
