class Reaction {
  int id;
  int post;
  int reactionOwner;
  bool isLike;

  Reaction({this.id, this.isLike, this.post, this.reactionOwner});

  factory Reaction.fromJson(Map<String,dynamic> json){
    return Reaction(id:json['id'] as int,
            post: json['post'] as int,
            reactionOwner: json['reaction_owner'] as int, 
            isLike: json['is_like'] as bool,
            );
  }

  @override
    String toString() {
      // TODO: implement toString
      return 'Reaction $isLike $post $reactionOwner';
    }
}