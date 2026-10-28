abstract class StringUtils {
  static String? trimOrNullIfBlank(String? text) {
    final String? trimmedText = text?.trim();
    return trimmedText == null || trimmedText.isEmpty ? null : trimmedText;
  }
}
