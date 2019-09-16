import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

saveId(int postId) async {
    final directory = await getApplicationDocumentsDirectory();
    Map<String, dynamic> data = Map();
    data['id'] = postId;
    File persist = File(directory.path +'/lastPostId.json');
    File(directory.path +'/lastPostId.json').existsSync() ? File(directory.path +'/lastPostId.json').deleteSync() : File(directory.path +'/lastPostId.json').createSync();
    persist.writeAsStringSync(json.encode(data));
}