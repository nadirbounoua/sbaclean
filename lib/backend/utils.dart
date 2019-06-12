import '../models/anomaly.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'dart:convert';

List<Anomaly> parsePost(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Anomaly>((json) => Anomaly.fromJson(json)).toList();
}