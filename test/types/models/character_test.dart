import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/types/models/character.dart';

import '../../fixtures/character_json_fixture.dart';

void main() {
  test("parses all fields", () {
    final Character character = Character.fromJson(CharacterJsonFixture.full());

    expect(character.id, CharacterJsonFixture.id);
    expect(character.name, CharacterJsonFixture.name);
    expect(character.imageUrl, CharacterJsonFixture.imageUrl);
    expect(character.publisherName, CharacterJsonFixture.publisherName);
    expect(character.deck, CharacterJsonFixture.deck);
  });

  test("falls back when optional fields are missing", () {
    final Character character = Character.fromJson(CharacterJsonFixture.minimal());

    expect(character.name, "");
    expect(character.imageUrl, isNull);
    expect(character.publisherName, isNull);
    expect(character.deck, isNull);
  });

  test("treats a blank deck as missing", () {
    final Character character = Character.fromJson({...CharacterJsonFixture.minimal(), "deck": "  "});

    expect(character.deck, isNull);
  });
}
