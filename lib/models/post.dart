import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/models/user.dart';
 
 class Post {

  int id;
  int postOwner;
  User owner;
  String title;
  String description;
  String longitude;
  String latitude;
  String createdAt;
  List<int> reactions = [];
  Reaction userReaction;
  String imageUrl; 
  List<int> comments;
  int reactionsCount;

  Post({this.title, 
          this.description, 
          this.longitude,
          this.latitude,
          this.id, 
          this.reactions,
          this.userReaction, 
          this.postOwner,
          this.imageUrl,
          this.comments,
          this.reactionsCount,
          this.createdAt
  });

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(id:json['id'] as int,
            description: json['description'] as String,
            title: json['title'] as String, 
            longitude: json['longitude'] as String,
            latitude: json['latitude'] as String,
            postOwner: json['post_owner'] as int,
            reactions: json['reactions'].cast<int>() as List<int>,
            imageUrl: json['image'] as String,
            comments: json['comments'].cast<int>() as List<int>,
            reactionsCount: json['reactions_count'] as int,
            createdAt: json['created_at'] as String
            );
  }

  @override
    String toString() {
      // TODO: implement toString
      return "Post $id $description $latitude $longitude $title";
    }
}