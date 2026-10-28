import 'package:dio/dio.dart';
import 'package:super_heroes/services/pagination/paginated_response.dart';
import 'package:super_heroes/types/models/character.dart';
import 'package:super_heroes/types/models/characters_response.dart';

class CharactersService {
  static const String _charactersPath = "/characters/";
  static const String _fieldList = "id,name,image,publisher,deck";

  static const int pageSize = 20;

  final Dio dio;

  CharactersService({required this.dio});

  Future<PaginatedResponse<Character>> getCharacters({required int page}) async {
    final int offset = PaginatedResponse.getOffset(page: page, pageSize: pageSize);
    final Response<Map<String, dynamic>> response = await dio.get(
      _charactersPath,
      queryParameters: {"limit": pageSize, "offset": offset, "field_list": _fieldList},
    );
    final CharactersResponse characters = CharactersResponse.fromJson(response.data!);
    return PaginatedResponse<Character>(
      data: characters.results,
      nextPage: PaginatedResponse.getNextPage(
        page: page,
        loadedItemsCount: offset + characters.results.length,
        itemsCount: characters.numberOfTotalResults,
      ),
      itemsCount: characters.numberOfTotalResults,
    );
  }
}
