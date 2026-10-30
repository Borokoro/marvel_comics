import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/cubits/search/search_cubit.dart';
import 'package:super_heroes/service_locator.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/view/pages/search/components/search_app_bar.dart';
import 'package:super_heroes/view/pages/search/components/search_results.dart';

@RoutePage(name: "SearchRoute")
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => SearchCubit(serviceLocator.get<CharactersService>()), child: _getScaffold());
  }

  Widget _getScaffold() {
    return const Scaffold(
      appBar: SearchAppBar(),
      body: SafeArea(child: SearchResults()),
    );
  }
}
