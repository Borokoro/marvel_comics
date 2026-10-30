import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/cubits/cubit_pagination_mixin/paginated_state.dart';
import 'package:super_heroes/cubits/cubit_pagination_mixin/pagination_mixin.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/services/pagination/paginated_response.dart';
import 'package:super_heroes/types/models/character.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> with PaginationMixin<Character, SearchState, SearchLoaded> {
  SearchCubit(this._charactersService) : super(const SearchInitial());
  final CharactersService _charactersService;

  @override
  Future<PaginatedResponse<Character>> Function(int page) get fetch =>
      (int page) => _charactersService.getCharacters(page: page, name: state.query);

  @override
  int get pageSize => CharactersService.pageSize;

  @override
  Object getItemId(Character item) => item.id;

  Future<void> search(String query) async {
    final String trimmedQuery = query.trim();
    final SearchState lastState = state;
    if (lastState is! SearchError && lastState.query == trimmedQuery) return;
    if (trimmedQuery.isEmpty) {
      emit(const SearchInitial());
      return;
    }
    emit(SearchLoading(trimmedQuery));
    try {
      final PaginatedResponse<Character> response = await fetchFirstPage();
      if (isClosed || state.query != trimmedQuery) return;
      emit(
        SearchLoaded(
          query: trimmedQuery,
          items: response.data,
          nextPage: response.nextPage,
          itemsCount: response.itemsCount,
        ),
      );
    } catch (_) {
      if (isClosed || state.query != trimmedQuery) return;
      emit(SearchError(trimmedQuery));
    }
  }

  Future<void> retrySearch() => search(state.query);

  void clearSearch() {
    emit(const SearchInitial());
  }
}
