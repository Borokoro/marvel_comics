import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:super_heroes/constants/env_constants.dart';

GetIt serviceLocator = GetIt.instance;

void _initializeClients() {
  serviceLocator.registerLazySingleton<Dio>(_createDio);
}

void _initializeServices() {}

void _initializeCubits() {}

Dio _createDio() {
  return Dio(BaseOptions(baseUrl: EnvConstants.apiBaseUrl));
}

void setupDependencies() {
  _initializeClients();
  _initializeServices();
  _initializeCubits();
}
