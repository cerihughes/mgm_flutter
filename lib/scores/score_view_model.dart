import 'package:mgm_flutter/data_repository/model.dart';

class ScoreViewModel {
  final Album _album;
  final int _index;
  final _Award _award;

  final String position;

  // String get albumName;
  // String get artistName;
  // String get rating;
  // String get position;

  ScoreViewModel(this._album, this._index, this.position)
      : _award = _createAward(_album.score ?? 0.0);

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
//
// var awardImage: UIImage? {
// return award.awardImage
// }
//
// var spotifyURL: URL? {
// guard let spotifyID = album.spotifyId else {
// return nil
// }
// return .createSpotifyAlbumURL(albumID: spotifyID)
// }
}

enum _Award { gold, silver, bronze, none }

extension _AwardBehaviour on _Award {
  // var awardImage: UIImage? {
  // switch self {
  // case .gold:
  // return UIImage(named: "gold")
  // case .silver:
  // return UIImage(named: "silver")
  // case .bronze:
  // return UIImage(named: "plate")
  // default:
  // return UIImage(named: "none")
  // }
  // }

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