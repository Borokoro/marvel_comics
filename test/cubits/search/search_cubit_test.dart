import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_heroes/cubits/search/search_cubit.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/services/pagination/paginated_response.dart';
import 'package:super_heroes/types/models/character.dart';

import '../../fixtures/character_json_fixture.dart';
import '../../mocks/mock_characters_service.dart';

void main() {
  late MockCharactersService charactersService;

  const String query = "ant";
  final Character first = Character.fromJson(CharacterJsonFixture.minimal(id: 1));
  final Character second = Character.fromJson(CharacterJsonFixture.minimal(id: 2));
  final Character nextPageCharacter = Character.fromJson(CharacterJsonFixture.minimal(id: 100));
  final List<Character> fullPage = List.generate(
    CharactersService.pageSize,
    (int index) => Character.fromJson(CharacterJsonFixture.minimal(id: index + 1)),
  );

  SearchCubit buildCubit() => SearchCubit(charactersService);

  setUp(() {
    charactersService = MockCharactersService();
  });

  test("initial state is SearchInitial with an empty query", () {
    final SearchCubit cubit = buildCubit();
    expect(cubit.state, const SearchInitial());
    expect(cubit.state.query, "");
    cubit.close();
  });

  group("search", () {
    blocTest<SearchCubit, SearchState>(
      "loads the first page for the trimmed query",
      build: () {
        when(() => charactersService.getCharacters(page: 1, name: query))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [first, second], itemsCount: 40, nextPage: 2));
        return buildCubit();
      },
      act: (SearchCubit cubit) => cubit.search("  $query "),
      expect: () => [
        const SearchLoading(query),
        SearchLoaded(query: query, items: [first, second], itemsCount: 40, nextPage: 2),
      ],
      verify: (_) => verify(() => charactersService.getCharacters(page: 1, name: query)).called(1),
    );

    blocTest<SearchCubit, SearchState>(
      "emits loaded with no items when nothing matches",
      build: () {
        when(() => charactersService.getCharacters(page: 1, name: query))
            .thenAnswer((_) async => const PaginatedResponse<Character>(data: [], itemsCount: 0));
        return buildCubit();
      },
      act: (SearchCubit cubit) => cubit.search(query),
      expect: () => [const SearchLoading(query), const SearchLoaded(query: query, items: [], itemsCount: 0)],
    );

    blocTest<SearchCubit, SearchState>(
      "emits error on failure",
      build: () {
        when(() => charactersService.getCharacters(page: 1, name: query)).thenThrow(Exception());
        return buildCubit();
      },
      act: (SearchCubit cubit) => cubit.search(query),
      expect: () => [const SearchLoading(query), const SearchError(query)],
    );

    blocTest<SearchCubit, SearchState>(
      "goes back to initial for a blank query",
      build: buildCubit,
      seed: () => SearchLoaded(query: query, items: [first], itemsCount: 1),
      act: (SearchCubit cubit) => cubit.search("   "),
      expect: () => [const SearchInitial()],
    );

    blocTest<SearchCubit, SearchState>(
      "does nothing when the query has not changed",
      build: buildCubit,
      seed: () => SearchLoaded(query: query, items: [first], itemsCount: 1),
      act: (SearchCubit cubit) => cubit.search("$query "),
      expect: () => [],
    );

    blocTest<SearchCubit, SearchState>(
      "ignores a response for an outdated query",
      build: () {
        when(() => charactersService.getCharacters(page: 1, name: query))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [first], itemsCount: 1));
        return buildCubit();
      },
      act: (SearchCubit cubit) {
        cubit.search(query);
        cubit.clearSearch();
      },
      expect: () => [const SearchLoading(query), const SearchInitial()],
    );
  });

  group("retrySearch", () {
    blocTest<SearchCubit, SearchState>(
      "searches again for the failed query",
      build: () {
        when(() => charactersService.getCharacters(page: 1, name: query))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [first], itemsCount: 1));
        return buildCubit();
      },
      seed: () => const SearchError(query),
      act: (SearchCubit cubit) => cubit.retrySearch(),
      expect: () => [
        const SearchLoading(query),
        SearchLoaded(query: query, items: [first], itemsCount: 1),
      ],
    );
  });

  group("loadMore", () {
    blocTest<SearchCubit, SearchState>(
      "appends the next page for the current query",
      build: () {
        when(() => charactersService.getCharacters(page: 2, name: query))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [nextPageCharacter], itemsCount: 21));
        return buildCubit();
      },
      seed: () => SearchLoaded(query: query, items: fullPage, itemsCount: 21, nextPage: 2),
      act: (SearchCubit cubit) => cubit.loadMore(),
      expect: () => [
        SearchLoaded(query: query, items: fullPage, itemsCount: 21, nextPage: 2, isLoadingMore: true),
        SearchLoaded(query: query, items: [...fullPage, nextPageCharacter], itemsCount: 21),
      ],
    );

    blocTest<SearchCubit, SearchState>(
      "drops the next page when the search was cleared meanwhile",
      build: () {
        when(() => charactersService.getCharacters(page: 2, name: query))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [nextPageCharacter], itemsCount: 21));
        return buildCubit();
      },
      seed: () => SearchLoaded(query: query, items: fullPage, itemsCount: 21, nextPage: 2),
      act: (SearchCubit cubit) {
        cubit.loadMore();
        cubit.clearSearch();
      },
      expect: () => [
        SearchLoaded(query: query, items: fullPage, itemsCount: 21, nextPage: 2, isLoadingMore: true),
        const SearchInitial(),
      ],
    );
  });
}
