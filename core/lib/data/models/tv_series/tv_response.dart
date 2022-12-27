import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvModel> tvList;

  const TvSeriesResponse({required this.tvList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
          tvList: List<TvModel>.from(
        (json['results'] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null),
      ));

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(
          tvList.map((x) => x.toJson()),
        )
      };

  @override
  List<Object?> get props => [tvList];
}
