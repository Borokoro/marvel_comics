import 'package:dio/dio.dart';
import 'package:super_heroes/constants/env_constants.dart';

class ComicVineInterceptor extends Interceptor {
  static const String _userAgentHeader = "User-Agent";
  static const String _userAgent = "SuperHeroesApp";
  static const String _apiKeyParameter = "api_key";
  static const String _formatParameter = "format";
  static const String _jsonFormat = "json";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[_userAgentHeader] = _userAgent;
    options.queryParameters.addAll({_apiKeyParameter: EnvConstants.comicVineApiKey, _formatParameter: _jsonFormat});
    handler.next(options);
  }
}
