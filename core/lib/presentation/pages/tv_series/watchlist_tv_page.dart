import 'package:core/presentation/bloc/tv_series/watchlist_tv_data/watchlist_tv_series_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils.dart';
import '../../../core.dart';
import '../../widgets/tv_series_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTvSeriesDataBloc>().add(FetchWatchlistSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesDataBloc>().add(FetchWatchlistSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            BlocBuilder<WatchlistTvSeriesDataBloc, WatchlistTvSeriesDataState>(
          builder: (context, state) {
            if (state is WatchlistTvSeriesDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvSeriesDataHasData) {
              return state.result.isNotEmpty
                  ? ListView(
                      children: [
                        Text(
                          'TV Series',
                          style: kHeading6,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final series = state.result[index];
                            return TvCard(series);
                          },
                          itemCount: state.result.length,
                        ),
                      ],
                    )
                  : const SizedBox();
            } else if (state is WatchlistTvSeriesDataError) {
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
