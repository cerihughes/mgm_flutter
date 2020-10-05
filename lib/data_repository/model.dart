class Event {
  int number;
  Location? location;
  DateTime? date;
  Playlist? playlist;
  Album? classicAlbum;
  Album? newAlbum;

  Event(this.number, this.location, this.date, this.playlist, this.classicAlbum,
      this.newAlbum);
}

class Location {
  String name;
  double latitude;
  double longitude;

  Location(this.name, this.latitude, this.longitude);
}

enum AlbumType { classic_album, new_album }

class Album {
  int eventNumber;
  AlbumType type;
  String? spotifyId;
  String? name;
  String? artist;
  double score;
  List<Image>? images;

  Album(this.eventNumber, this.type, this.spotifyId, this.name, this.artist,
      this.score, this.images);
}

class Playlist {
  String spotifyId;
  String name;
  String owner;
  List<Image>? images;

  Playlist(this.spotifyId, this.name, this.owner, this.images);
}

class Image {
  int? size;
  String url;

  Image(this.size, this.url);
}
