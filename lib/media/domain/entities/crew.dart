class PersonEntity {
  final int id;
  final String name;
  String? profilePath;

  PersonEntity({
    required this.id,
    required this.name,
    this.profilePath,
  });
}
