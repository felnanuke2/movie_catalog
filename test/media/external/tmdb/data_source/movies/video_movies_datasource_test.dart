import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/external/tmdb/data_source/movies/video_movies_datasource.dart';

import 'popular_movies_datasource_test.dart';

void main() {
  final client = HttpClientMock();
  final dataSource = TmdbVideoDatasource(client, id: '0');
  setUpAll(() {
    registerFallbackValue(Uri());
  });
  test('test if videodatasource returns a list when response is ok', () async {
    when(() => client.get(any())).thenAnswer((invocation) async =>
        Response(jsonEncode(MOCK_VIDEO_RESPONSE_200), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }));

    expect(await dataSource(), isA<List<VideoEntity>>());
  });

  test('test if videodatasource throws error when response is not ok',
      () async {
    when(() => client.get(any())).thenAnswer((invocation) async =>
        Response(jsonEncode(TMDB_MOCK_RESPONSE_401), 401, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }));

    expect(() async => await dataSource(), throwsA(isA<MediaRequestError>()));
  });
}

const MOCK_VIDEO_RESPONSE_200 = {
  "id": 550,
  "results": [
    {
      "iso_639_1": "en",
      "iso_3166_1": "US",
      "name": "Fight Club - Theatrical Trailer Remastered in HD",
      "key": "6JnN1DmbqoU",
      "site": "YouTube",
      "size": 1080,
      "type": "Trailer",
      "official": false,
      "published_at": "2015-02-26T03:19:25.000Z",
      "id": "5e382d1b4ca676001453826d"
    },
    {
      "iso_639_1": "en",
      "iso_3166_1": "US",
      "name": "Fight Club | #TBT Trailer | 20th Century FOX",
      "key": "BdJKm16Co6M",
      "site": "YouTube",
      "size": 1080,
      "type": "Trailer",
      "official": true,
      "published_at": "2014-10-02T19:20:22.000Z",
      "id": "5c9294240e0a267cd516835f"
    }
  ]
};
