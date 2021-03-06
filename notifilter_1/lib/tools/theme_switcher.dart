import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeSwitcher{

  ThemeSwitcher();

  void systemNavTheme(BuildContext context){ //SET NAV THEME
    Brightness theme1;
    if(Theme.of(context).canvasColor == Colors.black){
      theme1 = Brightness.dark;
    }else{
      theme1 = Brightness.dark;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).canvasColor, // navigation bar color
      statusBarColor: Theme.of(context).canvasColor, // status bar color
      statusBarIconBrightness: theme1, //status barIcon Brightness
      systemNavigationBarIconBrightness: theme1, //navigation bar icon
    ));
  }

}