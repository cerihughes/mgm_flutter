import 'dart:async';

import 'package:openapi/api.dart';

class RemoteDataSource {
  DefaultApi _defaultApi;

  RemoteDataSource(String basePath)
      : _defaultApi = DefaultApi(ApiClient(basePath: basePath));

  Future<List<EventApiModel>> loadEventData() async => await _defaultApi.events() ?? [];
}
