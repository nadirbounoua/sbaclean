 import 'package:learning2/models/reaction.dart';
 
 class Anomaly {

  int id;
  int post;
  int postOwner;
  String title;
  String description;
  String longitude;
  String latitude;
  List<int> reactions = [];
  Reaction userReaction;
  String imageUrl; 

  Anomaly({this.title, 
           this.description, 
           this.longitude,
           this.latitude,
           this.id, 
           this.reactions,
           this.userReaction, 
           this.postOwner,
           this.imageUrl,
           this.post
  });

  factory Anomaly.fromJson(Map<String,dynamic> json){
    return Anomaly(id:json['id'] as int,
            description: json['description'] as String,
            title: json['title'] as String, 
            longitude: json['longitude'] as String,
            latitude: json['latitude'] as String,
            postOwner: json['post_owner'] as int,
            reactions: json['reactions'].cast<int>() as List<int>,
            imageUrl: json['image'] as String,
            post: json['post'] as int
            );
  }

  @override
    String toString() {
      // TODO: implement toString
      return "Anomaly $id $description $latitude $longitude $title";
    }
}