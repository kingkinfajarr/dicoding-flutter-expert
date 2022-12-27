import 'package:core/domain/entities/tv_series/tv_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      final id = event.id;

      emit(TvSeriesDetailLoading());
      final result = await _getTvSeriesDetail.execute(id);

      result.fold(
        (failure) {
          emit(TvSeriesDetailError(failure.message));
        },
        (series) {
          emit(TvSeriesDetailHasData(series));
        },
      );
    });
  }
}
