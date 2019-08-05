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
      Anomaly anomaly = Anomaly.fromJson(json);
      anomaly.post = post;
      return anomaly;
}

Anomaly createFromJsonPost(dynamic json) {
  print(json.toString());
      Post post = Post.fromJson(json);
      Anomaly anomaly = Anomaly.fromJson(json);
      anomaly.post = post;
      return anomaly;
}


List<Reaction> parseReaction(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Reaction>((json) => Reaction.fromJson(json)).toList();
}


List<Comment> parseComment(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
}

List<User> parseUsers(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
}
User parseOneUser(String responseBody){
    final parsed = json.decode(responseBody);
    return User.fromJson(parsed);
}
Anomaly parseOneAnomaly(String responseBody){
    final parsed = json.decode(responseBody);

    return createFromJsonPost(parsed);
}

Post parseOnePost(String responseBody) {
  final parsed = jsonDecode(responseBody);
  
  return Post.fromJson(parsed);
}