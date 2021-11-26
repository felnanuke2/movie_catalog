import 'dart:convert';

class ProductionCopanies {
  final String name;
  final int id;
  final String? logoPath;
  final String originCountry;
  ProductionCopanies({
    required this.name,
    required this.id,
    this.logoPath,
    required this.originCountry,
  });

  factory ProductionCopanies.fromMap(Map<String, dynamic> map) {
    return ProductionCopanies(
      name: map['name'],
      id: map['id'],
      logoPath: map['logo_path'] != null ? map['logo_path'] : null,
      originCountry: map['origin_country'],
    );
  }

  factory ProductionCopanies.fromJson(String source) =>
      ProductionCopanies.fromMap(json.decode(source));
}
