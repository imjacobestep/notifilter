import 'package:flutter/material.dart';

class AppFiltered {
  String appName;
  String packageName;
  bool isChecked;
  MemoryImage appIcon;

  //AppFiltered({this.appName, this.appPackageName, this.appIcon, this.isChecked});

  AppFiltered({
    this.appName,
    this.packageName,
    this.appIcon,
    this.isChecked
  });

  AppFiltered.fromMap(Map<String, dynamic> map){
    appName = map['appName'];
    packageName = map['packageName'];
  }

}

