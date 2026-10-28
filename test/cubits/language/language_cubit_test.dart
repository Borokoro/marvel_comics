import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_heroes/cubits/language/language_cubit.dart';
import 'package:super_heroes/types/enum/language.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("initial state uses the device language", () {
    final LanguageCubit cubit = LanguageCubit();
    final Language expectedLanguage = Language.fromLangCode(
      TestWidgetsFlutterBinding.instance.platformDispatcher.locale.languageCode,
    );
    expect(cubit.state, LanguageInitial(expectedLanguage));
    cubit.close();
  });

  blocTest<LanguageCubit, LanguageState>(
    "switchLanguage emits SwitchingLanguage and SwitchedLanguage",
    build: () => LanguageCubit(),
    act: (LanguageCubit cubit) => cubit.switchLanguage(language: Language.pl),
    expect: () => [const SwitchingLanguage(Language.pl), const SwitchedLanguage(Language.pl)],
  );
}
