import 'dart:async';

import 'package:mgm_flutter/data_repository/remote_data_source.dart';
import 'package:openapi/api.dart';

class MockRemoteDataSource implements RemoteDataSource {
  late final List<EventApiModel> loadEventDataResponse;

  @override
  Future<List<EventApiModel>> loadEventData() {
    var completer = new Completer<List<EventApiModel>>();
    completer.complete(loadEventDataResponse);
    return completer.future;
  }
}
