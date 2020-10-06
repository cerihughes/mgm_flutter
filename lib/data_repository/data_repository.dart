import 'package:mgm_flutter/data_repository/remote_data_source.dart';
import 'model.dart';
import 'model_conversion.dart';

class DataRepository {
  RemoteDataSource _remoteDataSource;

  DataRepository(this._remoteDataSource);

  Future<List<Event>> loadEventData() async {
    return _remoteDataSource.loadEventData().then(
        (apiModels) => apiModels.map((event) => event.convert()).toList());
  }
}
