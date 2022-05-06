import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'apps.dart';
import 'package:notifilter_1/tools/utility.dart';
import '../main.dart';

class Filter {
  String filterName;
  int filterID;
  List<AppFiltered> appList;
  String fmText = '';
  bool filterState = true;
  bool filterMode = false;

  void writeMode(){
    if(filterMode){
      fmText = "Allowed";
    }else{
      fmText = "Blocked";
    }
  }

  List<AppFiltered> changeApp(ApplicationWithIcon app, int index, List<AppFiltered> aL, bool value){
    AppFiltered newApp = new AppFiltered(appName: app.appName, packageName: app.packageName, appIcon: MemoryImage(app.icon), isChecked: value);
    if(value = true){
      aL.add(newApp);
    }else{
      aL[index].isChecked = value;
    }
    return aL;
  }

  Filter({this.filterName, this.appList, this.filterMode, this.filterID});

  //['filterID', 'filterName', 'filterMode', 'filterState']

 Filter.fromMap(Map<String, dynamic> map){
   filterID = map['filterID'];
   filterName = map["filterName"];
   filterMode = intToBool(map["filterMode"]);
   filterState = intToBool(map["filterState"]);
   appList = [];
   writeMode();
 }

 void addApp(AppFiltered app){
   appList.add(app);
 }

  void update(Filter temp){
    this.filterName = temp.filterName;
    this.appList = temp.appList;
    this.filterMode = temp.filterMode;
    this.writeMode();
  }

  void toggle(bool fState){
    this.filterState = fState;
  }

  Widget build(BuildContext context) {
    if(filterMode){
      fmText = "Allowed";
    }else{
      fmText = "Blocked";
    }
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          border: Border.all(width: 3, color: Theme.of(context).textTheme.headline3.color),
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('#' + this.filterName,
                        style: Theme.of(context).textTheme.headline1
                    ),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: (){null;},
                      color: Theme.of(context).textTheme.headline1.color,
                      iconSize: 20,
                    )
                  ],
                ),
                Switch(
                  value: this.filterState,
                  onChanged: (value){

                  },
                  activeColor: Theme.of(context).textTheme.headline1.color,
                  activeTrackColor: Theme.of(context).primaryColor,
                  inactiveThumbColor: Theme.of(context).primaryColor,
                  inactiveTrackColor: Theme.of(context).disabledColor,

                ),
              ],
            ),
            Text("" + this.fmText + ": " + this.appList[0].appName + ", " + this.appList[1].appName + ", " + this.appList[2].appName + '…',
                style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.left,
            )
          ],
        )
    );
  }
}
