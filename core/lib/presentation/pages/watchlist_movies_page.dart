import 'package:core/presentation/bloc/movie/watchlist_movies_data/watchlist_movies_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils.dart';
import '../../core.dart';
import '../widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMoviesDataBloc>().add(FetchWatchlistMovies()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesDataBloc>().add(FetchWatchlistMovies());
    // context.read<WatchlistTvSeriesDataBloc>().add(FetchWatchlistSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesDataBloc, WatchlistMoviesDataState>(
          builder: (context, state) {
            if (state is WatchlistMoviesDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesDataHasData) {
              return state.result.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Movies',
                          style: kHeading6,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.only(bottom: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final movie = state.result[index];
                            return MovieCard(movie);
                          },
                          itemCount: state.result.length,
                        ),
                      ],
                    )
                  : const SizedBox();
            } else if (state is WatchlistMoviesDataError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
