import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/view/shared_components/widgets/infinite_scroll/load_more_indicator.dart';

class InfiniteScrollWidget extends StatelessWidget {
  const InfiniteScrollWidget({
    super.key,
    required this.items,
    required this.hasReachedEnd,
    required this.hasLoadMoreError,
    required this.loadMore,
    this.itemSpacing = 0,
    this.padding,
  });

  final List<Widget> items;
  final bool hasReachedEnd;
  final bool hasLoadMoreError;
  final Future<void> Function() loadMore;
  final double itemSpacing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: items.length + (hasReachedEnd ? 0 : 1),
      separatorBuilder: (_, _) => SizedBox(height: itemSpacing),
      itemBuilder: (BuildContext context, int index) {
        if (index < items.length) return items[index];
        return hasLoadMoreError ? _getRetryButton(context) : LoadMoreIndicator(loadMore: loadMore);
      },
    );
  }

  Widget _getRetryButton(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Center(
      child: TextButton(
        onPressed: loadMore,
        style: TextButton.styleFrom(foregroundColor: ColorConstants.textBrand),
        child: Text(localizations.loadMoreRetry),
      ),
    );
  }
}
