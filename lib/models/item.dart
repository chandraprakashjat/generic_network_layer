class MovieItem {
  MovieItem({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.images,
    required this.banner,
    required this.director,
    required this.savedDate,
    required this.ratings,
  });
  late final String id;
  late final String name;
  late final String type;
  late final String description;
  late final List<String> images;
  late final String banner;
  late final String director;
  late final String savedDate;
  late final double ratings;

  MovieItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
    banner = json['banner'];
    director = json['director'];
    savedDate = json['savedDate'];
    ratings = json['ratings'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['description'] = description;
    _data['images'] = images;
    _data['banner'] = banner;
    _data['director'] = director;
    _data['savedDate'] = savedDate;
    _data['ratings'] = ratings;
    return _data;
  }
}
