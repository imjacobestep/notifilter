import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:notifilter_1/models/filters.dart';
import 'package:notifilter_1/models/notifications.dart';
import 'package:notifilter_1/models/apps.dart';
import 'package:notifilter_1/tools/utility.dart';

class DBProvider{

  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'notifilter.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE filters (
          filterID INTEGER PRIMARY KEY, filterName TEXT, filterMode INT, filterState INT
          );
        ''');
        await db.execute('''
          CREATE TABLE apps (
          packageName TEXT UNIQUE, appName TEXT,
          PRIMARY KEY (packageName)
          );
        ''');
        await db.execute('''
          CREATE TABLE filter_apps (
          filterID INTEGER, packageName TEXT,
          FOREIGN KEY (filterID) REFERENCES filters(filterID),
          FOREIGN KEY (packageName) REFERENCES apps(packageName)
          )
        ''');
        await db.execute('''
          CREATE TABLE clusters (
          clusterID INTEGER PRIMARY KEY, eventName TEXT, eventTime TEXT, filterID INTEGER,
          FOREIGN KEY (filterID) REFERENCES filters(filterID)
          );
        ''');
        await db.execute('''
          CREATE TABLE notifications (
          notiID TEXT UNIQUE, appName TEXT, time TEXT, bigText TEXT, smallText TEXT, bigIcon INT, clusterID TEXT,
          PRIMARY KEY (notiID),
          FOREIGN KEY (clusterID) REFERENCES clusters(clusterID)
          );
        ''');
      },
      version: 1
    );
  }

  Future<void> createTemps() async {

    AppFiltered snapApp = new AppFiltered(appName: 'Snapchat',packageName:'com.snapchat',appIcon: null);
    AppFiltered instaApp = new AppFiltered(appName: 'Instagram',packageName:'com.instagram',appIcon: null);
    AppFiltered messagesApp = new AppFiltered(appName: 'Messages',packageName:'com.messages',appIcon: null);
    Filter tempFilter1 = Filter(filterName: 'class',appList: [snapApp, instaApp, messagesApp],filterMode: false, filterID: randomInt());
    Filter tempFilter2 = Filter(filterName: 'duty',appList: [snapApp, instaApp, messagesApp],filterMode: true, filterID: randomInt());
    await newFilter(tempFilter1);
    await newFilter(tempFilter2);

    SavedNotification temp1 = new SavedNotification(
        bigIcon: IconData(58717, fontFamily: 'MaterialIcons'),
        appName: 'Messages',
        bigText: 'Jeff',
        smallText: "I'm parked outside!",
        time: '3:06');
    SavedNotification temp2 = new SavedNotification(
        bigIcon: IconData(58717, fontFamily: 'MaterialIcons'),
        appName: 'Snapchat',
        bigText: 'Snap',
        smallText: "New snap from Jeff",
        time: '3:04');
    SavedNotification temp3 = new SavedNotification(
        bigIcon: IconData(58717, fontFamily: 'MaterialIcons'),
        appName: 'Instagram',
        bigText: 'New likes',
        smallText: "User_123 liked your post",
        time: '2:46');
    await newNotification(temp1);
    await newNotification(temp2);
    await newNotification(temp3);

  }

  Future<void> startupDB() async {
    final db = await database;
  }

  Future<void> newFilter(Filter f) async {
    final db = await database;
    await db.insert('filters', {'filterID': f.filterID, 'filterName': f.filterName, 'filterMode': boolToInt(f.filterMode), 'filterState': boolToInt(f.filterState)});
    for(int a = 0; a < f.appList.length; a++){
      await newApp(f.appList[a]);
      await newFilterApp(f.appList[a], f.filterID);
    }
  }

  Future<void> toggleFilter(Filter f) async {
    var values = Map<String, dynamic>();
    values['filterState'] = boolToInt(f.filterState);
    bool isOn = !f.filterMode;
    f.filterMode = isOn;
    updateFilter(f);
  }

  Future<List<Filter>> getFilters() async {
    final db = await database;
    List<Map> filtersMap = await db.rawQuery('''
      SELECT * FROM filters
    ''');
    List<Filter> filters = [];
    if(filtersMap.length > 0){
      for(int i = 0; i < filtersMap.length; i++){
        filters.add(Filter.fromMap(filtersMap[i]));
      }
    }
    for(int a = 0; a < filters.length; a++){
      List<AppFiltered> appList = await getFilterApps(filters[a].filterID);
      for(int b = 0; b < appList.length; b++){
        filters[a].appList.add(appList[b]);
      }
    }
    return filters;
  }

  Future<void> deleteFilter(Filter f) async {
    final db = await database;
    int filterID =  f.filterID;
    await db.delete('filters', where: 'filterID = ?', whereArgs: [f.filterID]);
    clearApps(f);
  }

  Future<void> updateFilter(Filter f) async {
    deleteFilter(f);
    newFilter(f);
  }

  Future<void> clearApps(Filter f) async {
    final db = await database;
    int filterID = f.filterID;
    await db.rawDelete('''
      DELETE FROM filter_apps
      WHERE filterID = $filterID;
    ''');
  }

  Future<void> newNotification(SavedNotification n) async {
    final db = await database;
    await db.rawInsert('''
      INSERT INTO notifications (
        notiID, appName, time, bigText, smallText, bigIcon, clusterID
      ) VALUES (?, ?, ?, ?, ?, ?, ?)
    ''', [n.notiID, n.appName, n.time, n.bigText, n.smallText, n.bigIcon.codePoint, n.clusterID]);
  }

  Future<List<SavedNotification>> getNotis() async {
    final db = await database;
    List<Map> maps = await db.query('notifications', columns: ['notiID', 'appName', 'time', 'bigText', 'smallText', 'bigIcon', 'clusterID']);
    List<SavedNotification> notifications = [];
    if(maps.length > 0){
      for(int i = 0; i < maps.length; i++){
        notifications.add(SavedNotification.fromMap(maps[i]));
      }
    }
    return notifications;
  }

  Future<void> deleteNoti(SavedNotification n) async {
    final db = await database;
    Key notiID =  n.notiID;
    await db.rawDelete('''
      DELETE FROM notifications
      WHERE notiID = $notiID;
    ''');
  }

  Future<void> newApp(AppFiltered a) async {
    final db = await database;
    await db.rawInsert('''
      INSERT OR IGNORE INTO apps (
        packageName, appName
      ) VALUES (?, ?)
    ''', [a.packageName, a.appName]);
  }

  Future<List<AppFiltered>> getFilterApps(int filterID) async {
    final db = await database;

    List<Map> appsMapA = await db.query("filter_apps",columns: ['packageName'] ,where: "filterID = ?", whereArgs: [filterID]);
    List<AppFiltered> appList = [];
    
    if(appsMapA.length > 0){
      for(int a = 0; a < appsMapA.length; a++){
        var appA = appsMapA[a];
        List<Map> appsMapB = await db.query('apps', columns: ['packageName', 'appName'], where: 'packageName = ?', whereArgs: [appA['packageName']]);
        if(appsMapB.isNotEmpty){
          Map appB = appsMapB[0];
          appList.add(AppFiltered.fromMap(appB));
        }
      }
    }
    return appList;
  }

  Future<void> newFilterApp(AppFiltered a, int filterID) async {
    final db = await database;
    String packageName = a.packageName;
    await db.insert('filter_apps', {'filterID': filterID, 'packageName': packageName});
  }
}