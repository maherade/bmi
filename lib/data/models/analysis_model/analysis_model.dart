class AnalysisModel {
  static const COLLECTION_NAME = 'MyAnalysis';
  String? userId;
  String? analysisId;
  int? height;
  int? weight;
  int? age;
  String? gender;
  String? stResult;

  AnalysisModel({
    required this.userId,
    required this.analysisId,
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.stResult,
  });

  AnalysisModel.fromJson(Map<String, dynamic> json)
      : this(
    userId: json["userId"],
    analysisId: json["analysisId"],
    height: json["height"],
    weight: json["weight"],
    age: json["age"],
    gender: json["gender"],
    stResult: json["stResult"],
  );

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "analysisId": analysisId,
      "height": height,
      "weight": weight,
      "age": age,
      "gender": gender,
      "stResult": stResult,
    };
  }

}