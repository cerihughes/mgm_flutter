import 'package:equatable/equatable.dart';

extension NullSupport on Equatable {
  Object unwrap(Object? nullable) {
    return nullable ?? Null;
  }
}

class Event extends Equatable {
  final int number;
  final Location? location;
  final DateTime? date;
  final Playlist? playlist;
  final Album? classicAlbum;
  final Album? newAlbum;

  Event(this.number, this.location, this.date, this.playlist, this.classicAlbum,
      this.newAlbum);

  @override
  List<Object> get props => [
        number,
        unwrap(location),
        unwrap(date),
        unwrap(playlist),
        unwrap(classicAlbum),
        unwrap(newAlbum)
      ];
}

class Location extends Equatable {
  final String name;
  final double latitude;
  final double longitude;

  Location(this.name, this.latitude, this.longitude);

  @override
  List<Object> get props => [name, latitude, longitude];
}

enum AlbumType { classic_album, new_album }

class Album extends Equatable {
  final int eventNumber;
  final AlbumType type;
  final String? spotifyId;
  final String? name;
  final String? artist;
  final double score;
  final List<Image>? images;

  Album(this.eventNumber, this.type, this.spotifyId, this.name, this.artist,
      this.score, this.images);

  @override
  List<Object> get props => [
        eventNumber,
        type,
        unwrap(spotifyId),
        unwrap(name),
        unwrap(artist),
        score,
        unwrap(images)
      ];
}

class Playlist extends Equatable {
  final String spotifyId;
  final String name;
  final String owner;
  final List<Image>? images;

  Playlist(this.spotifyId, this.name, this.owner, this.images);

  @override
  List<Object> get props => [spotifyId, name, owner, unwrap(images)];
}

class Image extends Equatable {
  final int? size;
  final String url;

  Image(this.size, this.url);

  @override
  List<Object> get props => [unwrap(size), url];
}
