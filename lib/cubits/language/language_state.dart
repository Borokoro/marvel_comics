part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  final Language language;

  const LanguageState(this.language);

  @override
  List<Object> get props => [language];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.language);
}

class SwitchingLanguage extends LanguageState {
  const SwitchingLanguage(super.language);
}

class SwitchedLanguage extends LanguageState {
  const SwitchedLanguage(super.language);
}
