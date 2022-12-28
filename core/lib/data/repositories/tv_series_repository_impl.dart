import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../domain/entities/tv_series/tv_detail.dart';
import '../../domain/entities/tv_series/tvseries.dart';
import '../../domain/repositories/tv_series/tv_series_repository.dart';
import '../datasources/tv_series/tv_local_data_source.dart';
import '../datasources/tv_series/tv_series_remote_data_source.dart';
import '../models/tv_series/tv_series_table.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTv() async {
    try {
      final result = await remoteDataSource.getNowPlayingTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail tvDetail) async {
    try {
      final result = await localDataSource
          .insertWatchlist(TvSeriesTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetail tvDetail) async {
    try {
      final result = await localDataSource
          .removeWatchlist(TvSeriesTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
