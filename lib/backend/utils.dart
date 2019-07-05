import 'package:learning2/models/comment.dart';
import 'package:learning2/screens/post/post.dart';

import '../models/anomaly.dart';
import '../models/user.dart';
import 'dart:convert';

List<Anomaly> parsePost(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Anomaly>((json) => Anomaly.fromJson(json)).toList();
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
    return Anomaly.fromJson(parsed);
}