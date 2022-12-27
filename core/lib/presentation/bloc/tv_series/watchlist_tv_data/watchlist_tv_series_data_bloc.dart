import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_data_event.dart';
part 'watchlist_tv_series_data_state.dart';

class WatchlistTvSeriesDataBloc
    extends Bloc<WatchlistTvSeriesDataEvent, WatchlistTvSeriesDataState> {
  final GetWatchlistTv getWatchlistSeries;

  WatchlistTvSeriesDataBloc(this.getWatchlistSeries)
      : super(WatchlistTvSeriesDataEmpty()) {
    on<FetchWatchlistSeries>((event, emit) async {
      emit(WatchlistTvSeriesDataLoading());

      final result = await getWatchlistSeries.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvSeriesDataError(failure.message));
        },
        (moviesData) {
          emit(WatchlistTvSeriesDataHasData(moviesData));
        },
      );
    });
  }
}
