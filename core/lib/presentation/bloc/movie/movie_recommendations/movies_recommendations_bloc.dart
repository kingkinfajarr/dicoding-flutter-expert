import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movies_recommendations_event.dart';
part 'movies_recommendations_state.dart';

class MoviesRecommendationsBloc
    extends Bloc<MoviesRecommendationsEvent, MoviesRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MoviesRecommendationsBloc(this.getMovieRecommendations)
      : super(MoviesRecommendationsEmpty()) {
    on<FetchRecommendations>((event, emit) async {
      final id = event.id;

      emit(MoviesRecommendationsLoading());
      final result = await getMovieRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(MoviesRecommendationsError(failure.message));
        },
        (recommendations) {
          emit(MoviesRecommendationsHasData(recommendations));
        },
      );
    });
  }
}
