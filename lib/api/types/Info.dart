class AnilistInfo {
  String? id;
  AnimeTitle? title;
  int? malId;
  List<String>? synonyms;
  bool? isLicensed;
  bool? isAdult;
  String? countryOfOrigin;
  Trailer? trailer;
  String? image;
  int? popularity;
  String? color;
  String? cover;
  String? description;
  String? status;
  int? releaseDate;
  StartDate? startDate;
  StartDate? endDate;
  int? totalEpisodes;
  int? currentEpisode;
  int? rating;
  int? duration;
  List<String>? genres;
  String? season;
  List<String>? studios;
  String? subOrDub;
  String? type;
  List<Recommendations>? recommendations;
  List<Characters>? characters;
  List<Relations>? relations;
  Mappings? mappings;
  List<Episodes>? episodes;

  AnilistInfo(
      {this.id,
      this.title,
      this.malId,
      this.synonyms,
      this.isLicensed,
      this.isAdult,
      this.countryOfOrigin,
      this.trailer,
      this.image,
      this.popularity,
      this.color,
      this.cover,
      this.description,
      this.status,
      this.releaseDate,
      this.startDate,
      this.endDate,
      this.totalEpisodes,
      this.currentEpisode,
      this.rating,
      this.duration,
      this.genres,
      this.season,
      this.studios,
      this.subOrDub,
      this.type,
      this.recommendations,
      this.characters,
      this.relations,
      this.mappings,
      this.episodes});

  AnilistInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? AnimeTitle.fromJson(json['title']) : null;
    malId = json['malId'];
    synonyms = json['synonyms'].cast<String>();
    isLicensed = json['isLicensed'];
    isAdult = json['isAdult'];
    countryOfOrigin = json['countryOfOrigin'];
    trailer =
        json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null;
    image = json['image'];
    popularity = json['popularity'];
    color = json['color'];
    cover = json['cover'];
    description = json['description'];
    status = json['status'];
    releaseDate = json['releaseDate'];
    startDate = json['startDate'] != null
        ? StartDate.fromJson(json['startDate'])
        : null;
    endDate =
        json['endDate'] != null ? StartDate.fromJson(json['endDate']) : null;
    totalEpisodes = json['totalEpisodes'];
    currentEpisode = json['currentEpisode'];
    rating = json['rating'];
    duration = json['duration'];
    genres = json['genres'].cast<String>();
    season = json['season'];
    studios = json['studios'].cast<String>();
    subOrDub = json['subOrDub'];
    type = json['type'];
    if (json['recommendations'] != null) {
      recommendations = <Recommendations>[];
      json['recommendations'].forEach((v) {
        recommendations!.add(Recommendations.fromJson(v));
      });
    }
    if (json['characters'] != null) {
      characters = <Characters>[];
      json['characters'].forEach((v) {
        characters!.add(Characters.fromJson(v));
      });
    }
    if (json['relations'] != null) {
      relations = <Relations>[];
      json['relations'].forEach((v) {
        relations!.add(Relations.fromJson(v));
      });
    }
    mappings =
        json['mappings'] != null ? Mappings.fromJson(json['mappings']) : null;
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['malId'] = malId;
    data['synonyms'] = synonyms;
    data['isLicensed'] = isLicensed;
    data['isAdult'] = isAdult;
    data['countryOfOrigin'] = countryOfOrigin;
    if (trailer != null) {
      data['trailer'] = trailer!.toJson();
    }
    data['image'] = image;
    data['popularity'] = popularity;
    data['color'] = color;
    data['cover'] = cover;
    data['description'] = description;
    data['status'] = status;
    data['releaseDate'] = releaseDate;
    if (startDate != null) {
      data['startDate'] = startDate!.toJson();
    }
    if (endDate != null) {
      data['endDate'] = endDate!.toJson();
    }
    data['totalEpisodes'] = totalEpisodes;
    data['currentEpisode'] = currentEpisode;
    data['rating'] = rating;
    data['duration'] = duration;
    data['genres'] = genres;
    data['season'] = season;
    data['studios'] = studios;
    data['subOrDub'] = subOrDub;
    data['type'] = type;
    if (recommendations != null) {
      data['recommendations'] =
          recommendations!.map((v) => v.toJson()).toList();
    }
    if (characters != null) {
      data['characters'] = characters!.map((v) => v.toJson()).toList();
    }
    if (relations != null) {
      data['relations'] = relations!.map((v) => v.toJson()).toList();
    }
    if (mappings != null) {
      data['mappings'] = mappings!.toJson();
    }
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Title {
  String? romaji;
  String? english;
  String? native;

  Title({this.romaji, this.english, this.native});

  Title.fromJson(Map<String, dynamic> json) {
    romaji = json['romaji'];
    english = json['english'];
    native = json['native'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['romaji'] = romaji;
    data['english'] = english;
    data['native'] = native;
    return data;
  }
}

class Trailer {
  String? id;
  String? site;
  String? thumbnail;

  Trailer({this.id, this.site, this.thumbnail});

  Trailer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    site = json['site'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['site'] = site;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class StartDate {
  int? year;
  int? month;
  int? day;

  StartDate({this.year, this.month, this.day});

  StartDate.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}

class Recommendations {
  int? id;
  int? malId;
  AnimeTitle? title;
  String? status;
  int? episodes;
  String? image;
  String? cover;
  int? rating;
  String? type;

  Recommendations(
      {this.id,
      this.malId,
      this.title,
      this.status,
      this.episodes,
      this.image,
      this.cover,
      this.rating,
      this.type});

  Recommendations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    malId = json['malId'];
    title = json['title'] != null ? AnimeTitle.fromJson(json['title']) : null;
    status = json['status'];
    episodes = json['episodes'];
    image = json['image'];
    cover = json['cover'];
    rating = json['rating'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['malId'] = malId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['status'] = status;
    data['episodes'] = episodes;
    data['image'] = image;
    data['cover'] = cover;
    data['rating'] = rating;
    data['type'] = type;
    return data;
  }
}

class AnimeTitle {
  String? romaji;
  String? english;
  String? native;
  String? userPreferred;

  AnimeTitle({this.romaji, this.english, this.native, this.userPreferred});

  AnimeTitle.fromJson(Map<String, dynamic> json) {
    romaji = json['romaji'];
    english = json['english'];
    native = json['native'];
    userPreferred = json['userPreferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['romaji'] = romaji;
    data['english'] = english;
    data['native'] = native;
    data['userPreferred'] = userPreferred;
    return data;
  }
}

class Characters {
  int? id;
  String? role;
  Name? name;
  String? image;
  List<VoiceActors>? voiceActors;

  Characters({this.id, this.role, this.name, this.image, this.voiceActors});

  Characters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    image = json['image'];
    if (json['voiceActors'] != null) {
      voiceActors = <VoiceActors>[];
      json['voiceActors'].forEach((v) {
        voiceActors!.add(VoiceActors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    if (voiceActors != null) {
      data['voiceActors'] = voiceActors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Name {
  String? first;
  String? last;
  String? full;
  String? native;
  String? userPreferred;

  Name({this.first, this.last, this.full, this.native, this.userPreferred});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    full = json['full'];
    native = json['native'];
    userPreferred = json['userPreferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['full'] = full;
    data['native'] = native;
    data['userPreferred'] = userPreferred;
    return data;
  }
}

class VoiceActors {
  int? id;
  String? language;
  Name? name;
  String? image;

  VoiceActors({this.id, this.language, this.name, this.image});

  VoiceActors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language'] = language;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class Relations {
  int? id;
  String? relationType;
  int? malId;
  AnimeTitle? title;
  String? status;
  int? episodes;
  String? image;
  String? color;
  String? type;
  String? cover;
  int? rating;

  Relations(
      {this.id,
      this.relationType,
      this.malId,
      this.title,
      this.status,
      this.episodes,
      this.image,
      this.color,
      this.type,
      this.cover,
      this.rating});

  Relations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relationType = json['relationType'];
    malId = json['malId'];
    title = json['title'] != null ? AnimeTitle.fromJson(json['title']) : null;
    status = json['status'];
    episodes = json['episodes'];
    image = json['image'];
    color = json['color'];
    type = json['type'];
    cover = json['cover'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['relationType'] = relationType;
    data['malId'] = malId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['status'] = status;
    data['episodes'] = episodes;
    data['image'] = image;
    data['color'] = color;
    data['type'] = type;
    data['cover'] = cover;
    data['rating'] = rating;
    return data;
  }
}

class Mappings {
  int? mal;
  int? anidb;
  int? kitsu;
  int? anilist;
  int? thetvdb;
  int? anisearch;
  int? livechart;
  String? notifyMoe;
  String? animePlanet;

  Mappings(
      {this.mal,
      this.anidb,
      this.kitsu,
      this.anilist,
      this.thetvdb,
      this.anisearch,
      this.livechart,
      this.notifyMoe,
      this.animePlanet});

  Mappings.fromJson(Map<String, dynamic> json) {
    mal = json['mal'];
    anidb = json['anidb'];
    kitsu = json['kitsu'];
    anilist = json['anilist'];
    thetvdb = json['thetvdb'];
    anisearch = json['anisearch'];
    livechart = json['livechart'];
    notifyMoe = json['notify.moe'];
    animePlanet = json['anime-planet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mal'] = mal;
    data['anidb'] = anidb;
    data['kitsu'] = kitsu;
    data['anilist'] = anilist;
    data['thetvdb'] = thetvdb;
    data['anisearch'] = anisearch;
    data['livechart'] = livechart;
    data['notify.moe'] = notifyMoe;
    data['anime-planet'] = animePlanet;
    return data;
  }
}

class Episodes {
  String? id;
  String? title;
  String? description;
  int? number;
  String? image;
  String? airDate;

  Episodes(
      {this.id,
      this.title,
      this.description,
      this.number,
      this.image,
      this.airDate});

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    number = json['number'];
    image = json['image'];
    airDate = json['airDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['number'] = number;
    data['image'] = image;
    data['airDate'] = airDate;
    return data;
  }
}
