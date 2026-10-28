import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marvel_comics/router/app_router.dart';
import 'package:marvel_comics/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MarvelComicsApp());
}

class MarvelComicsApp extends StatefulWidget {
  const MarvelComicsApp({super.key});

  @override
  State<MarvelComicsApp> createState() => _MarvelComicsAppState();
}

class _MarvelComicsAppState extends State<MarvelComicsApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(debugShowCheckedModeBanner: false, routerConfig: _appRouter.config());
  }
}
