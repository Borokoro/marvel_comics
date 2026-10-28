import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/utils/string_utils.dart';

void main() {
  group("trimOrNullIfBlank", () {
    test("returns trimmed text", () {
      expect(StringUtils.trimOrNullIfBlank("  Batman  "), "Batman");
    });

    test("returns null for blank text", () {
      expect(StringUtils.trimOrNullIfBlank("   "), isNull);
    });

    test("returns null for null", () {
      expect(StringUtils.trimOrNullIfBlank(null), isNull);
    });
  });
}
