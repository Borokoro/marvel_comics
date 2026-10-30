import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/constants/app_constants.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/constants/icon_constants.dart';
import 'package:super_heroes/constants/style_constants.dart';
import 'package:super_heroes/cubits/search/search_cubit.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/utils/text_theme_extension.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  static const double _height = 40;
  static const double _prefixIconWidth = 48;
  static const double _iconSize = 24;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late final Listenable _fieldListenable = Listenable.merge([_controller, _focusNode]);
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: _fieldListenable, builder: _getContent);
  }

  Widget _getContent(BuildContext context, Widget? child) {
    final bool shouldShowCancel = _focusNode.hasFocus || _controller.text.isNotEmpty;

    return Row(
      children: [
        Expanded(child: _getTextField(context)),
        if (shouldShowCancel) ...{_getCancelButton(context)},
      ],
    );
  }

  Widget _getTextField(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      style: textTheme.bodyBase16,
      cursorColor: ColorConstants.bgBrand,
      textInputAction: TextInputAction.search,
      onChanged: _onQueryChanged,
      onSubmitted: _search,
      decoration: _getDecoration(context),
    );
  }

  InputDecoration _getDecoration(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return InputDecoration(
      hintText: localizations.searchHint,
      hintStyle: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
      prefixIcon: const Icon(IconConstants.search, size: _iconSize, color: ColorConstants.iconSecondary),
      prefixIconConstraints: const BoxConstraints(minWidth: _prefixIconWidth, minHeight: _height),
      isDense: true,
      contentPadding: EdgeInsets.zero,
      filled: true,
      fillColor: ColorConstants.bgSurfaceAlt,
      border: const OutlineInputBorder(borderRadius: StyleConstants.radius8, borderSide: BorderSide.none),
    );
  }

  Widget _getCancelButton(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextButton(
      onPressed: _cancelSearch,
      style: TextButton.styleFrom(foregroundColor: ColorConstants.textMuted, textStyle: textTheme.bodyBase16),
      child: Text(localizations.cancel),
    );
  }

  void _onQueryChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(AppConstants.searchDebounceDuration, () => _search(query));
  }

  void _search(String query) {
    _debounceTimer?.cancel();
    context.read<SearchCubit>().search(query);
  }

  void _cancelSearch() {
    _debounceTimer?.cancel();
    _controller.clear();
    _focusNode.unfocus();
    context.read<SearchCubit>().clearSearch();
  }
}
