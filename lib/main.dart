import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_heroes/router/app_router.dart';
import 'package:super_heroes/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const SuperHeroesApp());
}

class SuperHeroesApp extends StatefulWidget {
  const SuperHeroesApp({super.key});

  @override
  State<SuperHeroesApp> createState() => _SuperHeroesAppState();
}

class _SuperHeroesAppState extends State<SuperHeroesApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(debugShowCheckedModeBanner: false, routerConfig: _appRouter.config());
  }
}
