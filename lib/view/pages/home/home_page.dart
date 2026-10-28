import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/cubits/characters/characters_cubit.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/service_locator.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/view/pages/home/components/characters_list.dart';
import 'package:super_heroes/view/shared_components/widgets/app_bar/title_app_bar.dart';

@RoutePage(name: "HomeRoute")
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: TitleAppBar(title: localizations.appTitle),
      body: SafeArea(child: _getCharactersList()),
    );
  }

  Widget _getCharactersList() {
    return BlocProvider(
      create: (_) => CharactersCubit(serviceLocator.get<CharactersService>()),
      child: const CharactersList(),
    );
  }
}
