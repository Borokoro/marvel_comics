import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:super_heroes/constants/env_constants.dart';
import 'package:super_heroes/cubits/language/language_cubit.dart';
import 'package:super_heroes/services/characters_service.dart';
import 'package:super_heroes/services/comic_vine_interceptor.dart';

GetIt serviceLocator = GetIt.instance;

void _initializeClients() {
  serviceLocator.registerLazySingleton<Dio>(_createDio);
}

void _initializeServices() {
  serviceLocator.registerSingleton<CharactersService>(CharactersService(dio: serviceLocator()));
}

void _initializeCubits() {
  serviceLocator.registerSingleton<LanguageCubit>(LanguageCubit());
}

Dio _createDio() {
  final Dio dio = Dio(BaseOptions(baseUrl: EnvConstants.apiBaseUrl));
  dio.interceptors.add(ComicVineInterceptor());
  return dio;
}

void setupDependencies() {
  _initializeClients();
  _initializeServices();
  _initializeCubits();
}
