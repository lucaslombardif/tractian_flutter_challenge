class CompanyEntity {
  final String id;
  final String name;

  const CompanyEntity({
    required this.id,
    required this.name,
  });

  factory CompanyEntity.fromJson(Map<String, dynamic> json) {
    return CompanyEntity(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
