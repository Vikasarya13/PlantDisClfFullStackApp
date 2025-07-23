class PlantDisDetail {
  String? predictedClass;
  double? confidence;

  PlantDisDetail({this.predictedClass, this.confidence});

  PlantDisDetail.fromJson(Map<String, dynamic> json) {
    predictedClass = json['predicted_class'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['predicted_class'] = this.predictedClass;
    data['confidence'] = this.confidence;
    return data;
  }
}