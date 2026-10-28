import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/view/shared_components/widgets/info_body.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({super.key, required this.title, required this.onRetryPressed});

  final String title;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return InfoBody(
      title: title,
      action: TextButton(
        onPressed: onRetryPressed,
        style: TextButton.styleFrom(foregroundColor: ColorConstants.textBrand),
        child: Text(localizations.retry),
      ),
    );
  }
}
