import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.errorWidget,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final Widget errorWidget;
  final BoxFit fit;

  static const double _loaderSize = 24;
  static const double _loaderStrokeWidth = 2;
  static const double _widestPhotoAspectRatio = 16 / 9;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorConstants.bgSurfaceAlt,
      child: LayoutBuilder(builder: _getImage),
    );
  }

  Widget _getImage(BuildContext context, BoxConstraints constraints) {
    return Image.network(
      imageUrl,
      fit: fit,
      cacheWidth: _getCacheWidth(context, constraints),
      loadingBuilder: _getLoadingWidget,
      errorBuilder: (_, _, _) => errorWidget,
    );
  }

  int? _getCacheWidth(BuildContext context, BoxConstraints constraints) {
    if (!constraints.hasBoundedWidth || !constraints.hasBoundedHeight) return null;
    final double requiredWidth = math.max(constraints.maxWidth, constraints.maxHeight * _widestPhotoAspectRatio);
    return (requiredWidth * MediaQuery.devicePixelRatioOf(context)).round();
  }

  Widget _getLoadingWidget(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    final int? expectedBytes = loadingProgress.expectedTotalBytes;

    return Center(
      child: SizedBox.square(
        dimension: _loaderSize,
        child: CircularProgressIndicator(
          value: expectedBytes != null ? loadingProgress.cumulativeBytesLoaded / expectedBytes : null,
          color: ColorConstants.bgBrand,
          strokeWidth: _loaderStrokeWidth,
        ),
      ),
    );
  }
}
