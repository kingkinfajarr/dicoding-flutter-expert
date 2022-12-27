import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTv _getTopRatedSeries;

  TopRatedTvSeriesBloc(this._getTopRatedSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<FetchTopRatedSeries>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await _getTopRatedSeries.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvSeriesError(failure.message));
        },
        (seriesData) {
          emit(TopRatedTvSeriesHasData(seriesData));
        },
      );
    });
  }
}
