import 'dart:convert';

class ProductionCountry {
  final String iso31661;
  final String name;
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'iso31661': iso31661,
      'name': name,
    };
  }

  factory ProductionCountry.fromMap(Map<String, dynamic> map) {
    return ProductionCountry(
      iso31661: map['iso31661'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionCountry.fromJson(String source) =>
      ProductionCountry.fromMap(json.decode(source));
}
