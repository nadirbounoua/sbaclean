import 'package:flutter/material.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/screens/user-history/widgets/list-tile.dart';

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      onExpansionChanged: (expanded) {
        
      },
      leading: Icon(Icons.keyboard_arrow_right),
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map((anomaly) => ListElement(anomaly: anomaly,)).toList(),
      trailing: Text(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}


class Entry {
  Entry({this.title, this.children = const []});

  String title;
  List<Anomaly> children;
}