import 'dart:convert';
import 'dart:io';
import 'package:openapi/api.dart';
import 'package:test/test.dart';

import 'data_repository/mock_remote_data_source.dart';
import 'package:mgm_flutter/data_repository/data_repository.dart';
import 'package:mgm_flutter/data_repository/model.dart';

void main() {
  test('API Models are converted to Models', () async {
    final remoteDataSource = MockRemoteDataSource();
    final dataRepository = DataRepository(remoteDataSource);

    final apiModels = _loadEventsJson(
        'test_resources/data_repository_test_full.json',
        (json) => EventApiModel.fromJson(json)!);
    remoteDataSource.loadEventDataResponse = apiModels;

    final expectedEventNumber = 78;
    final expectedClassicAlbum = Album(
        expectedEventNumber,
        AlbumType.classic_album,
        'classicId',
        'Classic Album',
        'Classic Artist',
        7.9, [
      AlbumArt(640, 'https://i.scdn.co/image/classic_640'),
      AlbumArt(300, 'https://i.scdn.co/image/classic_300')
    ]);

    final expectedNewAlbum = Album(expectedEventNumber, AlbumType.new_album,
        'newId', 'New Album', 'New Artist', 6.2, [
      AlbumArt(640, 'https://i.scdn.co/image/new_640'),
      AlbumArt(300, 'https://i.scdn.co/image/new_300')
    ]);

    final expectedPlaylist =
        Playlist('playlistId', 'Playlist Name', 'Playlist Owner', [
      AlbumArt(640, 'https://mosaic.scdn.co/640'),
      AlbumArt(300, 'https://mosaic.scdn.co/300')
    ]);

    final expectedLocation = Location('#StayAtHome', 1.234, 5.678);

    final expectedEvent = Event(
        expectedEventNumber,
        expectedLocation,
        DateTime.parse('2020-09-24'),
        expectedPlaylist,
        expectedClassicAlbum,
        expectedNewAlbum);

    expect(dataRepository.loadEventData(), completion(equals([expectedEvent])));
  });
}

List<EventApiModel> _loadEventsJson(
    String filename, EventApiModel func(dynamic)) {
  final jsonString = _fixture(filename);
  final jsonList = jsonDecode(jsonString) as List<dynamic>;
  return jsonList.map(func).toList();
}

String _fixture(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/$name').readAsStringSync();
}
