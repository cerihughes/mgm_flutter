import 'package:openapi/api.dart';
import 'model.dart';

extension EventConversion on EventApiModel {
  Event convert() {
    return Event(
        number,
        location?.convert(),
        DateTime.parse(date),
        playlist?.convert(),
        classicAlbum?.convert(number),
        newAlbum?.convert(number));
  }
}

extension LocationConversion on LocationApiModel {
  Location convert() {
    return Location(name, latitude, longitude);
  }
}

extension AlbumTypeConversion on String {
  AlbumType convert() {
    return this == "classic" ? AlbumType.classic_album : AlbumType.new_album;
  }
}

extension AlbumConversion on AlbumApiModel {
  Album convert(int eventNumber) {
    return Album(eventNumber, type.convert(), spotifyId, name, artist, score,
        images.map((image) => image.convert()).toList());
  }
}

extension PlaylistConversion on PlaylistApiModel {
  Playlist convert() {
    return Playlist(spotifyId, name, owner,
        images.map((image) => image.convert()).toList());
  }
}

extension ImageConversion on ImageApiModel {
  Image convert() {
    return Image(size, url);
  }
}
