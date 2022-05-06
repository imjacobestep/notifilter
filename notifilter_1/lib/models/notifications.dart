import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:notifilter_1/tools/utility.dart';

//SavedNotification notiFromJson(String str)  => SavedNotification.fromJson(json.decode(str));
//String notiToJson(SavedNotification data) => json.encode(data.toJson());

class SavedNotification{

  IconData bigIcon;
  Key notiID = UniqueKey();
  String appName = 'tempname';
  String bigText = 'tempheader';
  String smallText = 'temptext';
  String time = 'temptime';
  String clusterID;

  SavedNotification({
    this.bigIcon,
    this.notiID,
    @required this.appName,
    @required this.bigText,
    this.smallText,
    @required this.time
  });

  SavedNotification.fromMap(Map<String, dynamic> map){
    notiID = Key(map['notiID']);
    appName = map['appName'];
    time = map['time'];
    bigText = map['bigText'];
    smallText = map['smallText'];
    clusterID = map['clusterID'];
    bigIcon = IconData(map['bigIcon']);
  }
/*
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: Theme.of(context).canvasColor,
          border: Border.all(width: 3, color: Theme.of(context).textTheme.headline3.color),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              ClipRRect(
                //child: Icon(bigIcon, size: 26,),
                child: SizedBox.fromSize(
                  size: Size.fromHeight(26),
                  child: bigIcon,
                ),
                borderRadius: BorderRadius.all(Radius.circular(1)),
              ),
              SizedBox(width: 8,),
              Text(this.appName, style: Theme.of(context).textTheme.bodyText2), //NAME
              SizedBox(width: 8,),
              Text(this.time, style: Theme.of(context).textTheme.bodyText2), //TIME
            ],),
            SizedBox(height: 4,),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(this.bigText, style: Theme.of(context).textTheme.headline3), //BIG TEXT
              Text(this.smallText, style: Theme.of(context).textTheme.bodyText1), //SMALL TEXT
            ],)
          ],)
    );
  }
*/
}