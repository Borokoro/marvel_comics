import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/constants/style_constants.dart';
import 'package:super_heroes/cubits/characters/characters_cubit.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/types/models/character.dart';
import 'package:super_heroes/view/pages/home/components/character_card.dart';
import 'package:super_heroes/view/shared_components/widgets/error_body.dart';
import 'package:super_heroes/view/shared_components/widgets/infinite_scroll/infinite_scroll_refresh_widget.dart';
import 'package:super_heroes/view/shared_components/widgets/info_body.dart';
import 'package:super_heroes/view/shared_components/widgets/loading_indicator.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  static const double _cardsSpacing = 16;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersState>(builder: _mapStateToWidget);
  }

  Widget _mapStateToWidget(BuildContext context, CharactersState state) {
    if (state is CharactersLoaded) {
      return state.items.isEmpty ? _getEmptyBody(context) : _getCharactersList(context, state);
    } else if (state is CharactersError) {
      return _getErrorBody(context);
    } else if (state is CharactersInitial) {
      context.read<CharactersCubit>().fetchCharacters();
    }
    return const LoadingIndicator();
  }

  Widget _getCharactersList(BuildContext context, CharactersLoaded state) {
    final CharactersCubit cubit = context.read<CharactersCubit>();

    return InfiniteScrollRefreshWidget(
      items: state.items.map((Character character) => CharacterCard(character: character)).toList(),
      hasReachedEnd: state.hasReachedEnd,
      hasLoadMoreError: state.hasLoadMoreError,
      loadMore: cubit.loadMore,
      refreshContent: cubit.refreshCharacters,
      itemSpacing: _cardsSpacing,
      padding: StyleConstants.edgeInsetsH16V16,
    );
  }

  Widget _getEmptyBody(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return InfoBody(title: localizations.charactersEmpty);
  }

  Widget _getErrorBody(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return ErrorBody(
      title: localizations.charactersLoadingError,
      onRetryPressed: context.read<CharactersCubit>().fetchCharacters,
    );
  }
}
