import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/services/pagination/paginated_response.dart';
import 'package:super_heroes/types/models/character.dart';

import '../fixtures/character_json_fixture.dart';
import '../mocks/fake_http_client_adapter.dart';

void main() {
  late FakeHttpClientAdapter adapter;
  late CharactersService service;

  setUp(() {
    adapter = FakeHttpClientAdapter();
    service = CharactersService(dio: Dio()..httpClientAdapter = adapter);
  });

  test("requests a page of characters and parses it", () async {
    adapter.responseBody = {
      "status_code": 1,
      "number_of_total_results": 45,
      "results": [CharacterJsonFixture.full()],
    };

    final PaginatedResponse<Character> response = await service.getCharacters(page: 2);

    expect(adapter.lastRequest.method, "GET");
    expect(adapter.lastRequest.uri.path, "/characters/");
    expect(adapter.lastRequest.queryParameters, {
      "limit": CharactersService.pageSize,
      "offset": CharactersService.pageSize,
      "field_list": "id,name,image,publisher,deck",
    });
    expect(response.itemsCount, 45);
    expect(response.nextPage, 3);
    expect(response.data.single.id, CharacterJsonFixture.id);
  });

  test("filters characters by name", () async {
    adapter.responseBody = {"status_code": 1, "number_of_total_results": 0, "results": []};

    await service.getCharacters(page: 1, name: "ant");

    expect(adapter.lastRequest.queryParameters, {
      "limit": CharactersService.pageSize,
      "offset": 0,
      "field_list": "id,name,image,publisher,deck",
      "filter": "name:ant",
    });
  });

  test("has no next page when the last results are loaded", () async {
    adapter.responseBody = {
      "status_code": 1,
      "number_of_total_results": 21,
      "results": [CharacterJsonFixture.full()],
    };

    final PaginatedResponse<Character> response = await service.getCharacters(page: 2);

    expect(response.nextPage, isNull);
  });
}
