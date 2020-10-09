import 'package:flutter/rendering.dart';
import 'package:mgm_flutter/data_repository/model.dart';

class AlbumArtViewModel {
  static final _fallback = 'https://mgm-gcp.appspot.com/fallback.jpg';
  final List<AlbumArt>? _images;
  final int _loadingImageIndex;

  AlbumArtViewModel(this._images, this._loadingImageIndex);

  AssetImage get loadingImage {
    final imageName = "assets/album($_loadingImageIndex)";
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
        return candidate ?? image.url;
      }
    }

    return candidate;
  }
}
