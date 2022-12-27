import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tv_series/now_playing_tv/airing_today_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/popular_tv/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/top_rated_tv/top_rated_tv_series_bloc.dart';
import 'package:core/presentation/pages/tv_series/now_playing_tv_page.dart';
import 'package:core/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:core/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:core/presentation/pages/tv_series/tv_detail_page.dart';
import 'package:core/presentation/pages/tv_series/tv_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core.dart';
import '../../../domain/entities/tv_series/tvseries.dart';
import '../../provider/tv_series/tv_list_notifier.dart';
import '../../widgets/custom_drawer.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  const HomeTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvSeriesBloc>().add(
            FetchPopularTvSeries(),
          );
      context.read<TopRatedTvSeriesBloc>().add(
            FetchTopRatedSeries(),
          );
      context.read<AiringTodayTvSeriesBloc>().add(
            FetchAiringTodaySeries(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
              ),
              BlocBuilder<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
                builder: (context, state) {
                  if (state is AiringTodayTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AiringTodayTvSeriesHasData) {
                    return ListTV(state.result);
                  } else if (state is AiringTodayTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, state) {
                  if (state is PopularTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvSeriesHasData) {
                    return ListTV(state.result);
                  } else if (state is PopularTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvSeriesHasData) {
                    return ListTV(state.result);
                  } else if (state is TopRatedTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class ListTV extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const ListTV(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSerie = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tvSerie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSerie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
