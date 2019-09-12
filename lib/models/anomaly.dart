import 'package:sbaclean/models/post.dart'; 
 class Anomaly {

  int id;
  Post post;
  int postId;
  Anomaly({
           this.id, 
           this.post,
           this.postId
  });

  factory Anomaly.fromJson(Map<String,dynamic> json){

    return Anomaly(
            id:json['anomaly'][0]['id'] as int,

            );
  }

  factory Anomaly.fromJsonPost(Map<String,dynamic> json){

    return Anomaly(
            id:json['id'] as int,
            postId: json['post'] as int
            );
  }

  factory Anomaly.preFromJsonPost(Map<String,dynamic> json){

    return Anomaly(
            id:json['id'] as int,
            post: Post(
              id: json['post'] as int
            )
          );
  }

  Anomaly copyWith({Post post, int id}){
    return Anomaly(
      id: id ?? this.id,
      post: post ?? this.post
    );
  }

  @override
    String toString() {
      // TODO: implement toString
      return "Anomaly $id ";
    }
}