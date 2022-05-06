import 'package:flutter/material.dart';
import 'apps.dart';
import 'notifications.dart';
/*
class Cluster extends StatefulWidget{

  String eventName;
  String filterName;
  String eventDate;
  String eventTime;
  SavedNotification temp;
  List<SavedNotification> nL = List <SavedNotification>();

  Cluster({this.eventName, this.filterName, this.eventDate, this.eventTime, this.nL});

  Widget headerBuilder(BuildContext context){
    Key wKey = Key('header');
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row( //TOP ROW
        children: [
          Text("" + this.eventName, //EVENT NAME
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(" - " + this.eventDate, //EVENT DATE
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(" - " + this.eventTime, //EVENT TIME
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(' - #' + this.filterName, //EVENT TAG
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
  @override
  State<StatefulWidget> createState(){
    return _ClusterState();
  }
}

class _ClusterState extends State<Cluster> {

  @override
  ListView build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.nL.length + 1,
      itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: UniqueKey(),
              //child: widget.nL[index].build(context),
          );
      },

    );
  }
}

class NotiList{

  List<SavedNotification> nL = [];
  //NotiList();

  /*NotiList(){
    this.makeList();
  }*/

  /*void makeList(){

    SavedNotification temp1 = new SavedNotification(
        bigIcon: AssetImage('assets/messages.png'),
        appName: 'Messages',
        bigText: 'Jeff',
        smallText: "I'm parked outside!",
        time: '3:06');
    SavedNotification temp2 = new SavedNotification(
        bigIcon: AssetImage('assets/snapchat.png'),
        appName: 'Snapchat',
        bigText: 'Snap',
        smallText: "New snap from Jeff",
        time: '3:04');
    SavedNotification temp3 = new SavedNotification(
        bigIcon: AssetImage('assets/instagram.png'),
        appName: 'Instagram',
        bigText: 'New likes',
        smallText: "User_123 liked your post",
        time: '2:46');
    nL = [temp1, temp2, temp3];
  }*/

  List<SavedNotification> getList(){
    //this.makeList();
    return nL;
  }

}*/