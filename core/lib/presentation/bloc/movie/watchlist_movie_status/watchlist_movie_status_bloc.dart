import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_status_event.dart';
part 'watchlist_movie_status_state.dart';

class WatchlistMovieStatusBloc
    extends Bloc<WatchlistMovieStatusEvent, WatchlistMovieStatusState> {
  final GetWatchListStatus getWatchListStatus;

  WatchlistMovieStatusBloc(this.getWatchListStatus)
      : super(IsNotWatchlistMovies()) {
    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      result ? emit(IsWatchlistMovies()) : emit(IsNotWatchlistMovies());
    });
  }
}
