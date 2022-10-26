// table 컬럼명 : 당연히 전부 string
class SampleFields {
  static const String id = '_id';
  static const String name = 'name';
  static const String yn = 'yn';
  static const String value = 'value';
  static const String createdAt = 'createdAt';
}

class SampleModel {
  static const tableName = 'sample';
  final int? id; // 자동 증가
  final String name;
  final bool isYn;
  final double value;
  final DateTime createdAt;

  const SampleModel({
    this.id,
    required this.name,
    required this.isYn,
    required this.value,
    required this.createdAt,
  });

  // toJson
  Map<String, dynamic> toJson() {
    return {
      SampleFields.id: id,
      SampleFields.name: name,
      SampleFields.yn: isYn ? 1 : 0,
      SampleFields.value: value,
      SampleFields.createdAt: createdAt.toIso8601String(),
    };
  }

  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      id: json[SampleFields.id] as int?,
      name: json[SampleFields.name] == null
          ? ''
          : json[SampleFields.name] as String,
      isYn: json[SampleFields.yn] == null ? true : json[SampleFields.yn] == 1,
      value: json[SampleFields.value] == null
          ? 0
          : json[SampleFields.value] as double,
      createdAt: json[SampleFields.createdAt] == null
          ? DateTime.now()
          : DateTime.parse(json[SampleFields.createdAt] as String),
    );
  }

  SampleModel clone({
    int? id,
    String? name,
    bool? yn,
    double? value,
    DateTime? createdAt,
  }) {
    return SampleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isYn: yn ?? isYn,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
