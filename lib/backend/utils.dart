import 'package:http/http.dart';
import 'package:sbaclean/models/city.dart';
import 'package:sbaclean/models/event.dart';
import 'package:sbaclean/models/participation.dart';
import 'package:sbaclean/models/report.dart';

import '../models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'dart:convert';
import 'package:sbaclean/models/comment.dart';
import '../models/anomaly.dart';
import '../models/user.dart';
import 'package:sbaclean/models/post.dart';

List<Anomaly> parsePreAnomalies(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  
  return parsed.map<Anomaly>((json) {
    
      return Anomaly.preFromJsonPost(json);
    }).toList();
}

List<Anomaly> parseAnomalies(List<Response> responses){
    return responses.map<Anomaly>((response) {
      return createFromJson(json.decode(response.body));
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

Reaction parseOneReaction(String responseBody){
  List<dynamic> parsed = json.decode(responseBody);
  if (parsed.length > 0 )
  return Reaction.fromJson(parsed[0]);
  
  return null;
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
Anomaly parseOneAnomalyPost(dynamic responseBody){
    final parsed = json.decode(responseBody['response']);

    return createFromJsonPost(parsed,responseBody['post']);
}

Anomaly parseOneAnomaly(dynamic responseBody){
    final parsed = json.decode(responseBody);

    return Anomaly.fromJsonPost(parsed);
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

//--------------------------------------------------------

Event createFromJsonPostE(dynamic json, dynamic post) {
  Event event = Event.fromJsonPost(json);

  event.post = post;
  
  return event;
}

Event parseOneEvent(dynamic responseBody){
  final parsed = json.decode(responseBody['response']);
  return createFromJsonPostE(parsed,responseBody['post']);
}

Event createFromJsonEvent(dynamic json) {
  Post post = Post.fromJson(json);
  User user = User.fromJson(json['user']);
  Event event = Event.fromJson(json);
  post.owner = user;
  event.post = post;
  
  return event;
}

List<Event> parseEvents(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => createFromJsonEvent(json)).toList();
}


User parseProfile(String responseBody){
  List<dynamic> list = json.decode(responseBody);
  return User.fromJson(list[0]);
}

List<City> parseCities(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<City>((json) => City.fromJson(json)).toList();
}

List<Participation> parseParticipations(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Participation>((json) => Participation.fromJson(json)).toList();
}

List<Report> parseReports(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Report>((json) => Report.fromJson(json)).toList();
}


Participation parseOneParticipation(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return Participation.fromJson(parsed[0]);
}