import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';

class LoadMoreIndicator extends StatefulWidget {
  const LoadMoreIndicator({super.key, required this.loadMore});

  final Future<void> Function() loadMore;

  @override
  State<LoadMoreIndicator> createState() => _LoadMoreIndicatorState();
}

class _LoadMoreIndicatorState extends State<LoadMoreIndicator> {
  static const double _indicatorSize = 28;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.loadMore());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: _indicatorSize,
        child: CircularProgressIndicator(color: ColorConstants.bgBrand),
      ),
    );
  }
}
