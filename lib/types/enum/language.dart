enum Language {
  en(langCode: "en"),
  pl(langCode: "pl");

  final String langCode;

  const Language({required this.langCode});

  static Language fromLangCode(String? langCode) {
    for (final Language language in values) {
      if (language.langCode == langCode) return language;
    }
    return en;
  }
}
