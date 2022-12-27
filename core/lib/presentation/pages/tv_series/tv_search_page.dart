import 'package:core/presentation/bloc/tv_series/search_tv/tv_series_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core.dart';
import '../../widgets/tv_series_card_list.dart';

class TvSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';
  const TvSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context
                    .read<TvSeriesSearchBloc>()
                    .add(FetchSeriesSearch(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
              builder: (context, state) {
                if (state is TvSeriesSearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesSearchHasData) {
                  final result = state.result;
                  return result.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final series = result[index];
                              return TvCard(series);
                            },
                            itemCount: result.length,
                          ),
                        )
                      : const Expanded(
                          child: Center(
                            child: Text('Series not found.'),
                          ),
                        );
                } else if (state is TvSeriesSearchError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
