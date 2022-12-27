import 'package:core/domain/entities/tv_series/tvseries.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTv _getPopularTv;
  PopularTvSeriesBloc(this._getPopularTv) : super(PopularTvSeriesEmpty()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(PopularTvSeriesLoading());
      final result = await _getPopularTv.execute();

      result.fold(
        (failure) {
          emit(PopularTvSeriesError(failure.message));
        },
        (seriesData) {
          emit(PopularTvSeriesHasData(seriesData));
        },
      );
    });
  }
}
