import 'package:mgm_flutter/data_repository/data_repository.dart';
import 'package:mgm_flutter/data_repository/model.dart';
import 'score_view_model.dart';

class ScoresViewModel {
  final String title = 'Flutter Demo Home Page';
  final Future<List<ScoreViewModel>> albums;

  ScoresViewModel(DataRepository dataRepository)
      : albums = dataRepository
            .loadEventData()
            .then((events) => _sortedScoreViewModels(events));

  static List<ScoreViewModel> _sortedScoreViewModels(List<Event> events) {
    final sortedAlbums = _sortedAlbums(events);
    final positions = _positions(sortedAlbums);
    return sortedAlbums
        .asMap()
        .map((key, value) =>
            MapEntry(key, ScoreViewModel(value, key, positions[key])))
        .values
        .toList();
  }

  static List<Album> _sortedAlbums(List<Event> events) {
    final albums = events.expand((event) => event.scoredAlbums).toList();

    albums.sort((a, b) => _sortScores(a, b));
    return albums;
  }

  static int _sortScores(Album a, Album b) {
    final scoreA = a.score ?? 0.0;
    final scoreB = b.score ?? 0.0;
    if (scoreA != scoreB) {
      return scoreB.compareTo(scoreA); // Descending score
    }

    final nameA = a.name.toLowerCase();
    final nameB = b.name.toLowerCase();
    if (nameA != nameB) {
      return nameA.compareTo(nameB); // Ascending name
    }

    return a.artist
        .toLowerCase()
        .compareTo(b.artist.toLowerCase()); // Ascending Artist
  }

  static List<String> _positions(List<Album> albums) {
    final scores = albums.map((album) => album.score ?? 0.0).toList();
    var positions = List<String>.empty(growable: true);
    var currentPosition = 0;
    var currentValue = 11.0;

    for (var i = 0; i < scores.length; i++) {
      final value = scores[i];
      if (value != currentValue) {
        currentValue = value;
        currentPosition = i + 1;
      }
      positions.add(currentPosition.toString());
    }
    return positions;
  }
}

extension _Albums on Event {
  List<Album> get scoredAlbums {
    var results = List<Album>.empty(growable: true);
    if (classicAlbum?.score != null) {
      results.add(classicAlbum!);
    }
    if (newAlbum?.score != null) {
      results.add(newAlbum!);
    }
    return results;
  }
}
