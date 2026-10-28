import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/types/enum/language.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial(_getInitialLanguage()));

  static Language _getInitialLanguage() {
    return Language.fromLangCode(WidgetsBinding.instance.platformDispatcher.locale.languageCode);
  }

  void switchLanguage({required Language language}) {
    emit(SwitchingLanguage(language));
    emit(SwitchedLanguage(language));
  }
}
