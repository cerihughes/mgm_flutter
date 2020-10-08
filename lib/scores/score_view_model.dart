import 'package:flutter/painting.dart';
import 'package:mgm_flutter/album_art_view_model.dart';
import 'package:mgm_flutter/data_repository/model.dart';

class ScoreViewModel extends AlbumArtViewModel {
  final Album _album;
  final int _index;
  final _Award _award;

  final String position;

  ScoreViewModel(this._album, this._index, this.position)
      : _award = _createAward(_album.score ?? 0.0),
        super(_album.images);

  String get albumName {
    return _album.name;
  }

  String get artistName {
    return _album.artist;
  }

  String get rating {
    final score = _album.score;
    if (score == null) {
      return '';
    }
    return score.toStringAsFixed(1);
  }

// var ratingFontColor: UIColor {
// return award.ratingFontColor
// }

  AssetImage get awardImage {
    return _award.awardImage;
  }

// var spotifyURL: URL? {
// guard let spotifyID = album.spotifyId else {
// return nil
// }
// return .createSpotifyAlbumURL(albumID: spotifyID)
// }
}

enum _Award { gold, silver, bronze, none }

extension _AwardBehaviour on _Award {
  AssetImage get awardImage {
    switch (this) {
      case _Award.gold:
        return AssetImage('assets/gold.png');
      case _Award.silver:
        return AssetImage('assets/silver.png');
      case _Award.bronze:
        return AssetImage('assets/plate.png');
      default:
        return AssetImage('assets/none.png');
    }
  }

  // var ratingFontColor: UIColor {
  // switch self {
  // case .gold:
  // return .goldCup
  // case .silver:
  // return .silverCup
  // case .bronze:
  // return .bronzeCup
  // default:
  // return .greenCup
  // }
  // }
}

_Award _createAward(double score) {
  if (score > 8.5) {
    return _Award.gold;
  }
  if (score > 7.0) {
    return _Award.silver;
  }
  if (score > 5.5) {
    return _Award.bronze;
  }
  return _Award.none;
}
