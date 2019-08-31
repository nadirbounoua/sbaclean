import '../models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'dart:convert';
import 'package:sbaclean/models/comment.dart';
import '../models/anomaly.dart';
import '../models/user.dart';
import 'package:sbaclean/models/post.dart';

List<Anomaly> parseAnomalies(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Anomaly>((json) {
      
      return createFromJson(json);
      }).toList();
}
Anomaly createFromJson(dynamic json) {
      Post post = Post.fromJson(json);
      User user = User.fromJson(json['user']);
      Anomaly anomaly = Anomaly.fromJson(json);
      post.owner = user;
      anomaly.post = post;
      
      return anomaly;
}

Anomaly createFromJsonPost(dynamic json, dynamic post) {
      Anomaly anomaly = Anomaly.fromJsonPost(json);
      anomaly.post = post;
      return anomaly;
}


List<Reaction> parseReaction(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Reaction>((json) => Reaction.fromJson(json)).toList();
}

Comment createCommentFromJson(dynamic json) {
    Comment comment = Comment.fromJson(json);
    User user = User.fromJson(json['user']);
    comment.owner = user;      
    return comment;
}

Comment createCommentFromJsonPost(dynamic responseBody) {
    final parsed = json.decode(responseBody);
    Comment comment = Comment.fromJson(parsed);
    User user = User.fromJson(parsed['user']);
    comment.owner = user;      
    return comment;
}

List<Comment> parseComment(String responseBody){
  print(responseBody);
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Comment>((json) => createCommentFromJson(json)).toList();
}

List<User> parseUsers(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
}
User parseOneUser(String responseBody){
    final parsed = json.decode(responseBody);
    return User.fromJson(parsed);
}
Anomaly parseOneAnomaly(dynamic responseBody){
  print(responseBody);
    final parsed = json.decode(responseBody['response']);

    return createFromJsonPost(parsed,responseBody['post']);
}

Post parseOnePost(String responseBody) {
  final parsed = jsonDecode(responseBody);
  
  return Post.fromJson(parsed);
}

String calculateTime(dynamic date){
  Duration duration = DateTime.parse(date).difference(DateTime.now()).abs();
  String time = "Il y'a ";

  if (duration.inSeconds <= 59) time += duration.inSeconds.toString() + " secondes.";
  else if (duration.inMinutes <= 59) time += duration.inMinutes.toString() + " minutes.";
    else if (duration.inHours <= 23) time += duration.inHours.toString() + " heures.";
      else time += duration.inDays.toString() + " jours.";

  return time;

}