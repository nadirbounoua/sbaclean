import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/user_history_actions.dart';
import 'package:sbaclean/containers/profile_page.dart';
import 'package:sbaclean/screens/edit_screen.dart';
import 'package:sbaclean/screens/user-history/user-history.dart';
import 'package:sbaclean/screens/user-history/widgets/history_list.dart';
import 'package:sbaclean/screens/user_ranking/user_ranking_screen.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/actions/auth_actions.dart';
import 'main/widgets/image_chooser.dart';


class ProfileScreen extends StatefulWidget {
  String first_name;
  String last_name;
  String email;
  int phone;
  String address;
  String city;
  String profile_picture;
  ProfileScreen({this.first_name, this.last_name, this.email, this.phone, this.address, this.city, this.profile_picture});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileState(first_name: first_name,last_name: last_name,email: email, phone: phone,address: address, city: city, profile_picture: profile_picture);
  }
}

class _ProfileState extends State<ProfileScreen> {
  
  PageController _pageController;
  int _page = 0;
  String first_name;
  String last_name;
  String email;
  int phone;
  String address;
  String city;
  String profile_picture;

  _ProfileState({this.first_name, this.last_name, this.email, this.phone, this.address, this.city, this.profile_picture});

  

  Widget _buildProfileImage() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(

              boxShadow: [
                new BoxShadow(
                  color: Colors.grey[300],
                  offset: new Offset(20.0, 10.0),
                  blurRadius: 20.0,
                )
              ],
              image: DecorationImage(

                image:  NetworkImage(profile_picture),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(80.0),
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
            ),
          ),
          FlatButton(
            child: Text("edit"),
            onPressed: () async {
                 showDialog(
                  context: context,
                  builder: (context) {
                    return Material(
                      color: Colors.white.withOpacity(0.5),
                      child: StoreConnector<AppState,Store<AppState>> (
    converter: (store) =>  store,
    builder: (context,store) { return

                    Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top:300.0)
                            ,),
                          IconButton(
                            icon: (store.state.postFeedState.image == null) ? Icon(Icons.image,color: Colors.grey[800],) : Image.file(store.state.postFeedState.image,height: 200,width: 200,),
                            iconSize: (store.state.postFeedState.image != null ) ? 200 : 140,
                            onPressed:  () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ImageChooser();
                                  });

                              store.dispatch(new SetAnomalyImageAction());

                            },
                          ),
                          FlatButton(
                            child: store.state.auth.isEditingPicture? CircularProgressIndicator() : new Text("save"),
                            onPressed: (){
                              store.dispatch(modifyProfilePicture(context,store.state.auth.user.id.toString()
                                  ,store.state.auth.user.authToken));

                            },
                          ),
                        ],
                      );}),
                    );
                  });


            },
          ),
        ],
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );

    return Text(
      "$first_name $last_name",
      style: _nameTextStyle,
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        email,
        style: TextStyle(
          
          color: Colors.grey,
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.grey,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Padding(
          padding: EdgeInsets.all(2),
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer(BuildContext context, Store<AppState> store) {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
            new BoxShadow(
              color: Colors.grey[300],
              blurRadius: 20.0,
            )
          ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 18, bottom: 18),
        child:
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStatItem("Anomalies", store.state.userHistoryState.userPosts.length.toString()),
          _buildStatItem("Evénements", store.state.userHistoryState.userEvents.length.toString()),

        ],
      ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    TextStyle InfoTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              "Phone : $phone",
              textAlign: TextAlign.center,
              style: InfoTextStyle,
            ),
            Text(
              "Address : $address",
              textAlign: TextAlign.center,
              style: InfoTextStyle,
            ),
            Text(
              "City : $city",
              textAlign: TextAlign.center,
              style: InfoTextStyle,
            ),
          ],
        )
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
  Widget _buildButtons(Store<AppState> store) {
    bool showEvent = store.state.userHistoryState.showEvent;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
             BoxShadow(
              color: Colors.grey[300],
              blurRadius: 10.0,
            )
          ]
        ),
        child:Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                store.dispatch(ShowAnomalyAction());
              },
              focusColor: Colors.amber, // action
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color:  !showEvent ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))

                ),
                child: Center(
                  child: Text(
                    "Anomalies",
                    style: TextStyle(
                      color: !showEvent ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
              store.dispatch(ShowEventAction());

              }, //
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: showEvent ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Evénements",
                      
                      style: TextStyle(
                        color: showEvent ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return StoreConnector<AppState,Store<AppState>>(
      converter: (store) => store,
      onInit: (store) {

        store.dispatch(GetUserEventHistoryAction());
        store.dispatch(GetUserAnomaliesHistoryAction());

      },
      builder: (context,store) => Scaffold(
      body: Stack(
        children: <Widget>[
          
               ListView(
                children: <Widget>[
                  Padding(
                        padding: EdgeInsets.all(18),
                  ),
                  Row(

                    children: <Widget>[
                       Padding(
                        padding: EdgeInsets.all(12),
                      ),
                      _buildProfileImage(),
                      Padding(
                        padding: EdgeInsets.all(12),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildFullName(),
                          _buildEmail(context),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> EditScreen())),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8,18,8,18),
                    child:  _buildStatContainer(context, store),
                  ),

                  SizedBox(height: 10.0),
                  //_buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(store),
                  Column(
                    children: <Widget>[
                      Container(
                        width:MediaQuery.of(context).size.width,
                        child:Column(
                          children: <Widget>[
                            EventHistoryList()
                            
                          ],
                        ))
                    ],
                  )
                ],
              ),
            
          
        ],
      ),
    )
 ,
    );
}


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }


  
}