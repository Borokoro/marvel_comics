import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/cubits/language/language_cubit.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/router/app_router.dart';
import 'package:super_heroes/service_locator.dart';
import 'package:super_heroes/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const SuperHeroesApp());
}

class SuperHeroesApp extends StatefulWidget {
  const SuperHeroesApp({super.key});

  @override
  State<SuperHeroesApp> createState() => _SuperHeroesAppState();
}

class _SuperHeroesAppState extends State<SuperHeroesApp> {
  final LanguageCubit _languageCubit = serviceLocator.get<LanguageCubit>();
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: _languageCubit,
      builder: (context, state) {
        final String languageKey = state.language.langCode;
        return MaterialApp.router(
          locale: Locale.fromSubtags(languageCode: languageKey),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          theme: appTheme(context),
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
