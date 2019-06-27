import '../models/anomaly.dart';
import 'package:learning2/models/reaction.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'dart:convert';
List<Anomaly> parsePost(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Anomaly>((json) => Anomaly.fromJson(json)).toList();
}

List<Reaction> parseReaction(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Reaction>((json) => Reaction.fromJson(json)).toList();
}