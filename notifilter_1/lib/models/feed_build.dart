import 'package:flutter/material.dart';
import 'package:notifilter_1/models/filters.dart';
import 'package:notifilter_1/models/notifications.dart';
import 'package:notifilter_1/models/cluster.dart';
import 'package:notifilter_1/models/apps.dart';
import 'package:device_apps/device_apps.dart';
/*
class FeedListBuild{

  BuildContext context;
  List<SavedNotification> nL = [];
  List<Cluster> cL = [];
  List<Application> aL = [];

  FeedListBuild();



  Future<List<Application>> getApps() async{
    aL = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true, includeSystemApps: true);
    //setState(() {apps = _apps;});
    return aL;
  }


}

class NotificationList{

  List<SavedNotification> nL = [];
  NotificationList();

  void addNoti(SavedNotification n){
    nL.add(n);
  }

  void removeNoti(SavedNotification n){
    nL.remove(n);
  }

  void createNotis(){
    //ApplicationWithIcon messagesIcon = aL.singleWhere((Application) => Application.appName.compareTo('Messages') == 0);
    //ApplicationWithIcon snapIcon = aL.singleWhere((Application) => Application.appName.compareTo('Snapchat') == 0);
    //ApplicationWithIcon instaIcon = aL.singleWhere((Application) => Application.appName.compareTo('Insta') == 0);
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
    nL.add(temp1);
    nL.add(temp2);
    nL.add(temp3);
  }

  List<SavedNotification> getNotis(){
    createNotis();
    return nL;
  }

}

class FilterList{
  List<Filter> fL = [];

  FilterList(){
    AppFiltered snapApp = new AppFiltered(appName: 'Snapchat',appPackageName:'com.snapchat',appIcon: null);
    AppFiltered instaApp = new AppFiltered(appName: 'Instagram',appPackageName:'com.instagram',appIcon: null);
    AppFiltered messagesApp = new AppFiltered(appName: 'Messages',appPackageName:'com.messages',appIcon: null);

    List<AppFiltered> tempApps = [snapApp, instaApp, messagesApp];
    Filter tempFilter1 = Filter(filterName: 'class',appList: tempApps,filterMode: false);
    Filter tempFilter2 = Filter(filterName: 'duty',appList: tempApps,filterMode: false);
    fL.add(tempFilter1);
    fL.add(tempFilter2);
  }

  void createFilters(){
    AppFiltered snapApp = new AppFiltered(appName: 'Snapchat',appPackageName:'com.snapchat',appIcon: null);
    AppFiltered instaApp = new AppFiltered(appName: 'Instagram',appPackageName:'com.instagram',appIcon: null);
    AppFiltered messagesApp = new AppFiltered(appName: 'Messages',appPackageName:'com.messages',appIcon: null);

    List<AppFiltered> tempApps = [snapApp, instaApp, messagesApp];
    Filter tempFilter1 = Filter(filterName: 'class',appList: tempApps,filterMode: false);
    Filter tempFilter2 = Filter(filterName: 'duty',appList: tempApps,filterMode: false);
    fL.add(tempFilter1);
    fL.add(tempFilter2);
  }

  List<Filter> getFilters(){
    createFilters();
    return fL;
  }

  void addFilter(Filter f){
    fL.add(f);
  }

  void removeFilter(int index){
    fL.removeAt(index);
  }

  void updateFilter(int index, Filter f, bool isNew){
    f.appList.forEach((AppFiltered) {
      if (!AppFiltered.isChecked) {
        f.appList.remove(AppFiltered);
      }
    });
    if(f = null){

    }else if(!fL.contains(f)){
      fL.add(f);
    }else{
      fL[index].update(f);
    }
  }

}*/