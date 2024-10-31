class WebtoonDetailModel {
  final String title, age, about, genre;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        genre = json["genre"],
        age = json["age"],
        about = json["about"];
}
