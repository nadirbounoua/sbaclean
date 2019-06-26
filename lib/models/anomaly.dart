 class Anomaly {
  String title;
  String description;
  String longitude;
  String latitude;

  Anomaly({this.title , this.description, this.longitude,this.latitude });

  factory Anomaly.fromJson(Map<String,dynamic> json){
    return Anomaly(description: json['description'] as String,title: json['title'] as String);
  }

  @override
    String toString() {
      // TODO: implement toString
      return "Anomaly $description $latitude $longitude $title";
    }
}