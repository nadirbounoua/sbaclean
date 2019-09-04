import 'package:flutter/material.dart';

import 'package:sbaclean/presentation/platform_adaptive.dart';
import 'package:sbaclean/screens/user-history/user-history.dart';
import 'package:sbaclean/styles/texts.dart';
import 'package:sbaclean/screens/main_tabs/anomalies_tab.dart';
import 'package:sbaclean/screens/main_tabs/events_tab.dart';
import 'package:sbaclean/screens/main_tabs/posts_tab.dart';
import 'package:sbaclean/screens/main_drawer.dart';

import 'feed/feed.dart';
import 'settings/settings.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => new MainScreenState();

}
class MainScreenState extends State<MainScreen> {
    
    PageController _tabController;
    String _title;
    int _index;

    @override
    void initState() {
        super.initState();
        _tabController = new PageController();
        _title = TabItems[0].title;
        _index = 0;
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            
            appBar: new PlatformAdaptiveAppBar(
                title: new Text(_title),
                platform: Theme.of(context).platform
            ),
            
            bottomNavigationBar: new PlatformAdaptiveBottomBar(
                currentIndex: _index,
                onTap: onTap,
                items: TabItems.map((TabItem item) {
                    return new BottomNavigationBarItem(
                        title: new Text(
                            item.title,
                            style: textStyles['bottom_label'],
                        ),
                        icon: new Icon(item.icon),
                    );
                }).toList(),
            ),

            body: new PageView(
                controller: _tabController,
                onPageChanged: onTabChanged,
                children: <Widget>[
                    FeedScreen(),
                    EventsTab(),
                    UserHistoryScreen(),

                ],
            ),

            drawer: new MainDrawer(),
        );
    }

    void onTap(int tab){
        _tabController.jumpToPage(tab);
    }

    void onTabChanged(int tab) {
        setState((){
            this._index = tab;
        });
        
        this._title = TabItems[tab].title;
    }

}

class TabItem {
    final String title;
    final IconData icon;

    const TabItem({ this.title, this.icon });
}

const List<TabItem> TabItems = const <TabItem>[
    const TabItem(title: 'Anomalies', icon: Icons.broken_image),
    const TabItem(title: 'Events', icon: Icons.calendar_today),
    const TabItem(title: 'FeedTab', icon: Icons.group_work)
];