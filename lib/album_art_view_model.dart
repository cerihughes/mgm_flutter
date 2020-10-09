import 'package:flutter/rendering.dart';
import 'package:mgm_flutter/data_repository/model.dart';

class AlbumArtViewModel {
  static final _fallback = 'https://mgm-gcp.appspot.com/fallback.jpg';
  final List<AlbumArt>? _images;
  static int _loadingImageIndex = 0;

  AlbumArtViewModel(this._images);

  AssetImage get loadingImage {
    final index = (_loadingImageIndex % 3) + 1;
    _loadingImageIndex += 1;
    final imageName = "assets/album$index.png";
    return AssetImage(imageName);
  }

  String imageUrl(int largestDimension) {
    if (_images == null) {
      return _fallback;
    }

    var candidate = _fallback;
    for (var i = 0; i < _images!.length; i++) {
      var image = _images![i];
      if (image.size > largestDimension) {
        candidate = image.url;
      } else {
        return candidate;
      }
    }

    return candidate;
  }
}
