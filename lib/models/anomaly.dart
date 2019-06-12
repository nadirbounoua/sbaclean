 class Anomaly {
  String title;
  String description;

  Anomaly({this.title, this.description});

  factory Anomaly.fromJson(Map<String,dynamic> json){
    return Anomaly(description: json['description'] as String,title: json['title'] as String);
  }

}