// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Super Heroes App';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String publishedBy(String publisher) {
    return 'published by $publisher';
  }

  @override
  String get charactersLoadingError => 'Couldn\'t load the heroes';

  @override
  String get charactersEmpty => 'No heroes found';

  @override
  String get retry => 'Try again';

  @override
  String get loadMoreRetry => 'Load more';
}
