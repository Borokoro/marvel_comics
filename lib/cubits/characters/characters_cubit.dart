import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/cubits/cubit_pagination_mixin/paginated_state.dart';
import 'package:super_heroes/cubits/cubit_pagination_mixin/pagination_mixin.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/services/pagination/paginated_response.dart';
import 'package:super_heroes/types/models/character.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState>
    with PaginationMixin<Character, CharactersState, CharactersLoaded> {
  CharactersCubit(this._charactersService) : super(const CharactersInitial());
  final CharactersService _charactersService;

  @override
  Future<PaginatedResponse<Character>> Function(int page) get fetch =>
      (int page) => _charactersService.getCharacters(page: page);

  @override
  int get pageSize => CharactersService.pageSize;

  @override
  Object getItemId(Character item) => item.id;

  Future<void> fetchCharacters() async {
    emit(const CharactersLoading());
    try {
      final PaginatedResponse<Character> response = await fetchFirstPage();
      if (isClosed) return;
      emit(CharactersLoaded(items: response.data, nextPage: response.nextPage, itemsCount: response.itemsCount));
    } catch (_) {
      if (isClosed) return;
      emit(const CharactersError());
    }
  }

  Future<void> refreshCharacters() async {
    try {
      await refreshContent();
    } catch (_) {
      return;
    }
  }
}
