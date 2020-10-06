import 'package:openapi/api.dart';

class RemoteDataSource {
  DefaultApi _defaultApi;

  RemoteDataSource(String basePath)
      : _defaultApi = DefaultApi(ApiClient(basePath: basePath));

  Future<List<EventApiModel>> loadEventData() async => _defaultApi.events();
}
