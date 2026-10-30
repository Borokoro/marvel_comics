import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/constants/icon_constants.dart';
import 'package:super_heroes/constants/style_constants.dart';
import 'package:super_heroes/cubits/search/search_cubit.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/types/models/character.dart';
import 'package:super_heroes/view/shared_components/widgets/character_card.dart';
import 'package:super_heroes/view/shared_components/widgets/error_body.dart';
import 'package:super_heroes/view/shared_components/widgets/infinite_scroll/infinite_scroll_widget.dart';
import 'package:super_heroes/view/shared_components/widgets/info_body.dart';
import 'package:super_heroes/view/shared_components/widgets/loading_indicator.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  static const double _cardsSpacing = 16;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: _mapStateToWidget);
  }

  Widget _mapStateToWidget(BuildContext context, SearchState state) {
    if (state is SearchLoaded) {
      return state.items.isEmpty ? _getNoResultsBody(context) : _getResultsList(context, state);
    } else if (state is SearchError) {
      return _getErrorBody(context);
    } else if (state is SearchInitial) {
      return _getStartTypingBody(context);
    }
    return const LoadingIndicator();
  }

  Widget _getResultsList(BuildContext context, SearchLoaded state) {
    return InfiniteScrollWidget(
      items: state.items.map((Character character) => CharacterCard(character: character)).toList(),
      hasReachedEnd: state.hasReachedEnd,
      hasLoadMoreError: state.hasLoadMoreError,
      loadMore: context.read<SearchCubit>().loadMore,
      itemSpacing: _cardsSpacing,
      padding: StyleConstants.edgeInsetsH16V16,
    );
  }

  Widget _getStartTypingBody(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return InfoBody(icon: IconConstants.startSearch, title: localizations.searchStartTyping);
  }

  Widget _getNoResultsBody(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return InfoBody(icon: IconConstants.noResults, title: localizations.searchNoResults);
  }

  Widget _getErrorBody(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return ErrorBody(title: localizations.searchError, onRetryPressed: context.read<SearchCubit>().retrySearch);
  }
}
