import 'package:device_apps/device_apps.dart';
import 'package:notifilter_1/models/filters.dart';
import 'package:notifilter_1/models/notifications.dart';
import 'package:notifilter_1/tools/database.dart';

List<SavedNotification> notiList;
List<Application> appList;
List<Filter> filterList;
DBProvider db;

Future<void> initStore() async {
  await DBProvider.db.startupDB();
  List<Filter> fL = await DBProvider.db.getFilters();
  List<SavedNotification> nL = await DBProvider.db.getNotis();
  filterList = fL;
  notiList = nL;
}

Future<void> updateFilterList() async {
  List<Filter> fL = await DBProvider.db.getFilters();
  filterList = fL;
}

Future<void> updateNotiList() async {
  List<SavedNotification> nL = await DBProvider.db.getNotis();
  notiList = nL;
}

Future<void> createAppList() async{

  appList = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true, includeSystemApps: true);
}

List<Application> getApps() {
  return appList;
}

void addNoti(SavedNotification n){
  notiList.add(n);
  DBProvider.db.newNotification(n);
}

void removeNoti(SavedNotification n){
  notiList.remove(n);
  DBProvider.db.deleteNoti(n);
}

List<SavedNotification> getNotis(){
  return notiList;
}

List<Filter> getFilters(){
  return filterList;
}

void toggle(bool fState, Filter f){
  f.toggle(fState);
  DBProvider.db.toggleFilter(f);
}

void addFilter(Filter f){
  filterList.add(f);
  DBProvider.db.newFilter(f);
}

void removeFilter(int index){
  Filter temp = filterList[index];
  filterList.removeAt(index);
  DBProvider.db.deleteFilter(temp);
}

void saveFilter(Filter f){
  if(filterList.any((Filter) => Filter.filterID == f.filterID)){
    filterList.singleWhere((Filter) => Filter.filterID == f.filterID).update(f);
    DBProvider.db.updateFilter(f);
  }else{
    addFilter(f);
  }
}