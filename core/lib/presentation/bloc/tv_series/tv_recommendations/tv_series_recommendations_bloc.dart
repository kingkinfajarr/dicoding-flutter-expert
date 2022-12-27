import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendations_event.dart';
part 'tv_series_recommendations_state.dart';

class TvSeriesRecommendationsBloc
    extends Bloc<TvSeriesRecommendationsEvent, TvSeriesRecommendationsState> {
  final GetTvRecommendations _getTvSeriesRecommendations;

  TvSeriesRecommendationsBloc(this._getTvSeriesRecommendations)
      : super(TvSeriesRecommendationsEmpty()) {
    on<FetchRecommendations>((event, emit) async {
      final id = event.id;

      emit(TvSeriesRecommendationsLoading());
      final result = await _getTvSeriesRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(TvSeriesRecommendationsError(failure.message));
        },
        (recommendations) {
          emit(TvSeriesRecommendationsHasData(recommendations));
        },
      );
    });
  }
}
