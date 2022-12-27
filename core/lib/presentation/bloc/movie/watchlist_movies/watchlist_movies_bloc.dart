import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchlistMoviesBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistMoviesInitial()) {
    on<AddWatchlist>((event, emit) async {
      final movie = event.movie;
      emit(WatchlistMoviesInitial());
      final result = await saveWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          emit(WatchlistMoviesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMoviesAdded(successMessage));
        },
      );
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final movie = event.movie;
      emit(WatchlistMoviesInitial());
      final result = await removeWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          emit(WatchlistMoviesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMoviesRemoved(successMessage));
        },
      );
    });
  }
}
