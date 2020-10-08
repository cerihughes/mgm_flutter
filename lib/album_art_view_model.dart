import 'package:mgm_flutter/data_repository/model.dart';

class AlbumArtViewModel {
  final List<AlbumArt>? _images;

  AlbumArtViewModel(this._images);

  String? imageUrl(int largestDimension) {
    if (_images == null) {
      return null;
    }

    String? candidate;
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
