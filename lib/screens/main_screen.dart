import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_search/material_search.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/actions.dart';
import 'package:sbaclean/actions/auth_actions.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/main.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/main.dart';
import 'package:sbaclean/presentation/platform_adaptive.dart';
import 'package:sbaclean/screens/maps/maps.dart';
import 'package:sbaclean/screens/user-history/user-history.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/styles/texts.dart';
import 'package:sbaclean/screens/main_tabs/anomalies_tab.dart';
import 'package:sbaclean/screens/main_tabs/events_tab.dart';
import 'package:sbaclean/screens/main_tabs/posts_tab.dart';
import 'package:sbaclean/screens/main_drawer.dart';

import 'anomaly_details/anomaly_details.dart';
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
    List<Anomaly> anomalies = [];

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
            
            appBar: AppBar(
              title:Text(_title,),
              actions: (_index ==0) ? <Widget>[
                IconButton(
                  onPressed: () {
                    _showMaterialSearch(context);
                  },
                  tooltip: 'Search',
                  icon: new Icon(Icons.search),
                )] : null,
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

            body: StoreConnector<AppState,Store<AppState>>(
              converter: (store) => store,
              onInit: (store) {
                store.dispatch(GetUserPositionAction().getUserPosition());
              },
              builder:(context,store) => PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                onPageChanged: onTabChanged,
                children: <Widget>[
                    FeedScreen(),
                    EventsTab(),
                    MapSample()
                ],
            ), 
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

      _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
      .push(_buildMaterialSearchPage(context))
      .then((dynamic value) {
      });
  }

   _buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<dynamic>(
      settings: new RouteSettings(
        name: 'material_search',
        isInitialRoute: false,
      ),
      builder: (BuildContext context) {
        return new Material(
          child: new MaterialSearch<dynamic>(
            placeholder: 'Search',
            getResults: (String criteria) async {
              if (criteria.isEmpty) {
                setState(() {
                 anomalies = [];
               });
              } else {
              var list = await api.copyWith(MyApp.store.state.auth.user.authToken)
                                  .queryPosts(criteria);
               setState(() {
                 anomalies = parseAnomalies(list);
               });
              }
              return anomalies.map((anomaly) => new MaterialSearchResult<dynamic>(
                value: anomaly, //The value must be of type <String>
                text: anomaly.post.title, //String that will be show in the list
                //icon: anomaly.imageUrl == "/media/images/default.png" ? Icons.image : ImageIcon(Image.network(src))
                //.network(anomaly.imageUrl ,width: 24, height: 24,)
              )).toList();
            },

            onSelect: (dynamic value) => Navigator.push(context, MaterialPageRoute(builder: (context) => AnomalyDetails(anomaly: value,))),
            onSubmit: (dynamic value) => Navigator.push(context, MaterialPageRoute(builder: (context) => AnomalyDetails(anomaly: value,))),
          ),
        );
      }
    );
  }
}

class TabItem {
    final String title;
    final IconData icon;

    const TabItem({ this.title, this.icon });
}

const List<TabItem> TabItems = const <TabItem>[
    const TabItem(title: 'Anomalies', icon: Icons.warning),
    const TabItem(title: 'Evénements', icon: Icons.calendar_today),
    const TabItem(title: 'Carte', icon: Icons.map)
];

