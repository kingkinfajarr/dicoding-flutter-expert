import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'airing_today_tv_series_event.dart';
part 'airing_today_tv_series_state.dart';

class AiringTodayTvSeriesBloc
    extends Bloc<FetchAiringTodaySeries, AiringTodayTvSeriesState> {
  final GetNowPlayingTvSeries _getAiringTodaySeries;

  AiringTodayTvSeriesBloc(this._getAiringTodaySeries)
      : super(AiringTodayTvSeriesEmpty()) {
    on<FetchAiringTodaySeries>((event, emit) async {
      emit(AiringTodayTvSeriesLoading());
      final result = await _getAiringTodaySeries.execute();

      result.fold(
        (failure) {
          emit(AiringTodayTvSeriesError(failure.message));
        },
        (seriesData) {
          emit(AiringTodayTvSeriesHasData(seriesData));
        },
      );
    });
  }
}
