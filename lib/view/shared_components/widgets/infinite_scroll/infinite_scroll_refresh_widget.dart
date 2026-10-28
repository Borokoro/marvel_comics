import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/view/shared_components/widgets/infinite_scroll/infinite_scroll_widget.dart';

class InfiniteScrollRefreshWidget extends StatelessWidget {
  const InfiniteScrollRefreshWidget({
    super.key,
    required this.items,
    required this.hasReachedEnd,
    required this.hasLoadMoreError,
    required this.loadMore,
    required this.refreshContent,
    this.itemSpacing = 0,
    this.padding,
  });

  final List<Widget> items;
  final bool hasReachedEnd;
  final bool hasLoadMoreError;
  final Future<void> Function() loadMore;
  final Future<void> Function() refreshContent;
  final double itemSpacing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorConstants.bgBrand,
      onRefresh: refreshContent,
      child: InfiniteScrollWidget(
        items: items,
        hasReachedEnd: hasReachedEnd,
        hasLoadMoreError: hasLoadMoreError,
        loadMore: loadMore,
        itemSpacing: itemSpacing,
        padding: padding,
      ),
    );
  }
}
