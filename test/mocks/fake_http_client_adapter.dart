import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class FakeHttpClientAdapter implements HttpClientAdapter {
  final List<RequestOptions> requests = [];
  Map<String, dynamic> responseBody = const {};

  RequestOptions get lastRequest => requests.last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(responseBody),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
