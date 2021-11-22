import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/credit_datasource.dart';
import 'package:movie_catalog/media/domain/data_sources/details_datasource.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';

/// this repository is responsible for managing all request involving [Movies]
abstract class MediaRepository {
  /// get popular Movies and can be receive a index of ```page = 1``` if null
  Future<Either<MediaRequestError, List<MediaEntity>>> getMedia(
      MediaDataSource dataSource);

  /// need receive a ```movieId``` to get the credit of a Movie.
  /// the credit  contains ```Crew``` and ```Cast``` of a Src.
  Future<Either<MediaRequestError, CreditEntity>> getCredits(
      CreditDataSource dataSource);

  /// Need receive a ```movieId``` to get the Movie Details.
  Future<Either<MediaRequestError, DetailsEntity>> getDetails(
      DetailsDataSource dataSource);

  /// Get the related videos like ```Trailers``` ```MakingOf``` ...
  Future<Either<MediaRequestError, List<VideoEntity>>> getVideosList(
      VideoDataSource dataSource);
}
