import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_heroes/cubits/characters/characters_cubit.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/services/pagination/paginated_response.dart';
import 'package:super_heroes/types/models/character.dart';

import '../../fixtures/character_json_fixture.dart';
import '../../mocks/mock_characters_service.dart';

void main() {
  late MockCharactersService charactersService;

  final Character first = Character.fromJson(CharacterJsonFixture.minimal(id: 1));
  final Character second = Character.fromJson(CharacterJsonFixture.minimal(id: 2));
  final Character third = Character.fromJson(CharacterJsonFixture.minimal(id: 3));
  final Character nextPageCharacter = Character.fromJson(CharacterJsonFixture.minimal(id: 100));
  final List<Character> fullPage = List.generate(
    CharactersService.pageSize,
    (int index) => Character.fromJson(CharacterJsonFixture.minimal(id: index + 1)),
  );

  CharactersCubit buildCubit() => CharactersCubit(charactersService);

  setUp(() {
    charactersService = MockCharactersService();
  });

  test("initial state is CharactersInitial", () {
    final CharactersCubit cubit = buildCubit();
    expect(cubit.state, const CharactersInitial());
    cubit.close();
  });

  group("fetchCharacters", () {
    blocTest<CharactersCubit, CharactersState>(
      "loads the first page",
      build: () {
        when(() => charactersService.getCharacters(page: 1))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [first, second], itemsCount: 40, nextPage: 2));
        return buildCubit();
      },
      act: (CharactersCubit cubit) => cubit.fetchCharacters(),
      expect: () => [
        const CharactersLoading(),
        CharactersLoaded(items: [first, second], itemsCount: 40, nextPage: 2),
      ],
      verify: (_) => verify(() => charactersService.getCharacters(page: 1)).called(1),
    );

    blocTest<CharactersCubit, CharactersState>(
      "emits error on failure",
      build: () {
        when(() => charactersService.getCharacters(page: 1)).thenThrow(Exception());
        return buildCubit();
      },
      act: (CharactersCubit cubit) => cubit.fetchCharacters(),
      expect: () => [const CharactersLoading(), const CharactersError()],
    );
  });

  group("loadMore", () {
    blocTest<CharactersCubit, CharactersState>(
      "appends the next page",
      build: () {
        when(() => charactersService.getCharacters(page: 2))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [nextPageCharacter], itemsCount: 21));
        return buildCubit();
      },
      seed: () => CharactersLoaded(items: fullPage, itemsCount: 21, nextPage: 2),
      act: (CharactersCubit cubit) => cubit.loadMore(),
      expect: () => [
        CharactersLoaded(items: fullPage, itemsCount: 21, nextPage: 2, isLoadingMore: true),
        CharactersLoaded(items: [...fullPage, nextPageCharacter], itemsCount: 21),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      "flags a load more error",
      build: () {
        when(() => charactersService.getCharacters(page: 2)).thenThrow(Exception());
        return buildCubit();
      },
      seed: () => CharactersLoaded(items: fullPage, itemsCount: 21, nextPage: 2),
      act: (CharactersCubit cubit) => cubit.loadMore(),
      expect: () => [
        CharactersLoaded(items: fullPage, itemsCount: 21, nextPage: 2, isLoadingMore: true),
        CharactersLoaded(items: fullPage, itemsCount: 21, nextPage: 2, hasLoadMoreError: true),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      "does nothing when the end is reached",
      build: buildCubit,
      seed: () => CharactersLoaded(items: [first], itemsCount: 1),
      act: (CharactersCubit cubit) => cubit.loadMore(),
      expect: () => [],
    );
  });

  group("refreshCharacters", () {
    blocTest<CharactersCubit, CharactersState>(
      "replaces items with the first page and clears load more flags",
      build: () {
        when(() => charactersService.getCharacters(page: 1))
            .thenAnswer((_) async => PaginatedResponse<Character>(data: [third], itemsCount: 1));
        return buildCubit();
      },
      seed: () => CharactersLoaded(items: [first, second], itemsCount: 2, nextPage: 2, hasLoadMoreError: true),
      act: (CharactersCubit cubit) => cubit.refreshCharacters(),
      expect: () => [
        CharactersLoaded(items: [third], itemsCount: 1),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      "keeps the current state on failure",
      build: () {
        when(() => charactersService.getCharacters(page: 1)).thenThrow(Exception());
        return buildCubit();
      },
      seed: () => CharactersLoaded(items: [first], itemsCount: 2, nextPage: 2),
      act: (CharactersCubit cubit) => cubit.refreshCharacters(),
      expect: () => [],
    );
  });
}
