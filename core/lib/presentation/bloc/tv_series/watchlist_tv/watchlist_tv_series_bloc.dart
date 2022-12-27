import 'package:core/domain/entities/tv_series/tv_detail.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  WatchlistTvSeriesBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistTvSeriesInitial()) {
    on<AddWatchlist>((event, emit) async {
      final series = event.series;
      emit(WatchlistTvSeriesInitial());
      final result = await saveWatchlist.execute(series);

      await result.fold(
        (failure) async {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvSeriesAdded(successMessage));
        },
      );
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final series = event.series;
      emit(WatchlistTvSeriesInitial());
      final result = await removeWatchlist.execute(series);

      await result.fold(
        (failure) async {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvSeriesRemoved(successMessage));
        },
      );
    });
  }
}
