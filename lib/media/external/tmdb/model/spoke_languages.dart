import 'dart:convert';

class TmdbSpokenLanguageModel {
  final String englishName;
  final String iso6391;
  final String name;
  TmdbSpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory TmdbSpokenLanguageModel.fromMap(Map<String, dynamic> map) {
    return TmdbSpokenLanguageModel(
      englishName: map['english_name'],
      iso6391: map['iso6391'],
      name: map['name'],
    );
  }

  factory TmdbSpokenLanguageModel.fromJson(String source) =>
      TmdbSpokenLanguageModel.fromMap(json.decode(source));
}
