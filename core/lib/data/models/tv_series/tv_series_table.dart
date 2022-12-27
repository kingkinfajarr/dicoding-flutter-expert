import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series/tv_detail.dart';
import '../../../domain/entities/tv_series/tvseries.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? overview;
  final String? posterPath;
  final String? name;

  const TvSeriesTable({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  factory TvSeriesTable.fromEntity(TvDetail tvDetail) => TvSeriesTable(
        id: tvDetail.id,
        name: tvDetail.name,
        posterPath: tvDetail.posterPath,
        overview: tvDetail.overview,
      );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
        id: map['id'],
        overview: map['overview'],
        posterPath: map['posterPath'],
        name: map['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'overview': overview,
        'posterPath': posterPath,
        'name': name,
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, overview, posterPath, name];
}
