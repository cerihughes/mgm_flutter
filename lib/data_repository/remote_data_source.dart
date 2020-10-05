import 'package:openapi/api.dart';

class RemoteDataSource {
  DefaultApi _defaultApi;

  RemoteDataSource(String basePath) {
    var apiClient = ApiClient(basePath: basePath);
    _defaultApi = DefaultApi(apiClient);
  }

  Future<List<EventApiModel>> loadEventData() async => _defaultApi.events();
}
