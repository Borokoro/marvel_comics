import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/constants/icon_constants.dart';
import 'package:super_heroes/l10n/app_localizations.dart';
import 'package:super_heroes/router/app_router.gr.dart';

@RoutePage(name: "LandingRoute")
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const double _iconsSize = 24;

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(routes: const [HomeRoute(), SearchRoute()], bottomNavigationBuilder: _getNavigationBar);
  }

  Widget _getNavigationBar(BuildContext context, TabsRouter tabsRouter) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      iconSize: _iconsSize,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: ColorConstants.bgCanvas,
      selectedItemColor: ColorConstants.iconActive,
      unselectedItemColor: ColorConstants.iconInactive,
      items: [
        BottomNavigationBarItem(icon: const Icon(IconConstants.home), label: localizations.home),
        BottomNavigationBarItem(icon: const Icon(IconConstants.search), label: localizations.search),
      ],
    );
  }
}
