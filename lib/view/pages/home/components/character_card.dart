import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/constants/style_constants.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/types/models/character.dart';
import 'package:super_heroes/utils/elements_spacing_extension.dart';
import 'package:super_heroes/utils/text_theme_extension.dart';
import 'package:super_heroes/view/shared_components/widgets/network_image_widget.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final Character character;

  static const double _height = 184;
  static const double _imageWidth = 116;
  static const double _sectionsSpacing = 12;
  static const double _headerSpacing = 2;
  static const double _descriptionLineHeight = 1.4;
  static const int _nameMaxLines = 2;
  static const int _descriptionMaxLines = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: ColorConstants.bgSurface,
        borderRadius: StyleConstants.radius8,
        boxShadow: StyleConstants.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getImage(),
          Expanded(child: _getDetails(context)),
        ],
      ),
    );
  }

  Widget _getImage() {
    final String? imageUrl = character.imageUrl;
    const Widget placeholder = ColoredBox(color: ColorConstants.bgSurfaceAlt);

    return SizedBox(
      width: _imageWidth,
      child: imageUrl != null ? NetworkImageWidget(imageUrl: imageUrl, errorWidget: placeholder) : placeholder,
    );
  }

  Widget _getDetails(BuildContext context) {
    final String? deck = character.deck;
    final bool shouldShowDeck = deck != null;

    return Padding(
      padding: StyleConstants.edgeInsets16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHeader(context),
          if (shouldShowDeck) ...{Expanded(child: _getDeck(context, deck))},
        ].withVerticalElementsSpacing(_sectionsSpacing),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String? publisherName = character.publisherName;
    final bool shouldShowPublisher = publisherName != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(character.name, style: textTheme.headingH3_24, maxLines: _nameMaxLines, overflow: TextOverflow.ellipsis),
        if (shouldShowPublisher) ...{
          Text(
            localizations.publishedBy(publisherName),
            style: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        },
      ].withVerticalElementsSpacing(_headerSpacing),
    );
  }

  Widget _getDeck(BuildContext context, String deck) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      deck,
      style: textTheme.bodyBase16.copyWith(height: _descriptionLineHeight),
      maxLines: _descriptionMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
