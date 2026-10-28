import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/types/enum/language.dart';

void main() {
  test("maps supported language codes", () {
    expect(Language.fromLangCode("en"), Language.en);
    expect(Language.fromLangCode("pl"), Language.pl);
  });

  test("falls back to english for unsupported or missing codes", () {
    expect(Language.fromLangCode("de"), Language.en);
    expect(Language.fromLangCode(null), Language.en);
  });
}
