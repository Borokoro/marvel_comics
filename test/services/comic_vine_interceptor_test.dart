import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/constants/env_constants.dart';
import 'package:super_heroes/services/comic_vine_interceptor.dart';

import '../mocks/fake_http_client_adapter.dart';

void main() {
  test("adds the api key, json format and user agent to every request", () async {
    final FakeHttpClientAdapter adapter = FakeHttpClientAdapter();
    final Dio dio = Dio()
      ..httpClientAdapter = adapter
      ..interceptors.add(ComicVineInterceptor());

    await dio.get("/characters/", queryParameters: {"limit": 20});

    expect(adapter.lastRequest.queryParameters, {
      "limit": 20,
      "api_key": EnvConstants.comicVineApiKey,
      "format": "json",
    });
    expect(adapter.lastRequest.headers["User-Agent"], "SuperHeroesApp");
  });
}
