// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Super Heroes App';

  @override
  String get home => 'Strona główna';

  @override
  String get search => 'Szukaj';

  @override
  String publishedBy(String publisher) {
    return 'wydawca: $publisher';
  }

  @override
  String get charactersLoadingError => 'Nie udało się wczytać bohaterów';

  @override
  String get charactersEmpty => 'Nie znaleziono bohaterów';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get loadMoreRetry => 'Wczytaj więcej';

  @override
  String get searchHint => 'Szukaj superbohatera';

  @override
  String get cancel => 'Anuluj';

  @override
  String get searchStartTyping =>
      'Zacznij pisać, aby znaleźć konkretnego superbohatera.';

  @override
  String get searchNoResults =>
      'W naszej bibliotece nie ma superbohatera o takiej nazwie. Sprawdź pisownię i spróbuj ponownie.';

  @override
  String get searchError => 'Nie udało się wyszukać bohaterów';
}
