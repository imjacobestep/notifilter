import 'package:flutter/material.dart';
import 'package:notifilter_1/tools/listener_service.dart';
import 'models/apps.dart';
import 'pages/editor_page.dart';
import 'pages/settings_page.dart';
import 'pages/splash_screen.dart';
import 'tools/theme_switcher.dart';
import 'models/filters.dart';
import 'models/notifications.dart';
import 'package:device_apps/device_apps.dart';
import 'package:get/get.dart';
import 'pages/notifications_page.dart';
import 'tools/init_function.dart';
import 'tools/central_store.dart' as Store;
import 'tools/utility.dart';

void main() {
  runApp(Notifilter());
  startForegroundTask();
}

class ThemeVars{
  int textOpacity = 100;
  Color accentLight = new Color(0xffE1BEE7);
  Color accentAgnostic = new Color(0xffAB47BC);
  Color accentDark = new Color(0xff9C27B0);
  Color bkgLight = new Color(0xffF3E5F5);
  Color bkgAgnostic = new Color(0xffE5E5E5);
  Color bkgDark = new Color(0xff333333);
  Color alertLight = new Color(0xffFFA6A6);
  //Color alertLight = Colors.red;
  Color alertAgnostic = new Color(0xffFF3838);
  Color alertDark = new Color(0xff800000);
}

//THEMES AND STUFF
class Notifilter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NotiFilter',
      theme: ThemeData(
        primaryColor: ThemeVars().bkgLight,
        accentColor: ThemeVars().accentLight,
        canvasColor: Colors.white,
        disabledColor: ThemeVars().bkgLight,
        errorColor: ThemeVars().alertLight,
        unselectedWidgetColor: Colors.black,
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 16, color: Colors.black.withAlpha(ThemeVars().textOpacity)),
            headline3: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            headline4: TextStyle(fontSize: 20, color: Colors.black.withAlpha(ThemeVars().textOpacity)),
            bodyText1: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
            bodyText2: TextStyle(fontSize: 14, color: Colors.black.withAlpha(ThemeVars().textOpacity)),
            subtitle1: TextStyle(fontSize: 18, color: ThemeVars().alertLight, fontWeight: FontWeight.bold),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primaryColor: ThemeVars().bkgDark,
        accentColor: ThemeVars().accentDark,
        canvasColor: Colors.black,
        disabledColor: ThemeVars().bkgDark,
        errorColor: ThemeVars().alertDark,
        unselectedWidgetColor: Colors.white70,
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 16, color: Colors.white70.withAlpha(ThemeVars().textOpacity)),
            headline3: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.bold),
            headline4: TextStyle(fontSize: 20, color: Colors.white70.withAlpha(ThemeVars().textOpacity)),
            bodyText1: TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.normal),
            bodyText2: TextStyle(fontSize: 14, color: Colors.white70.withAlpha(ThemeVars().textOpacity)),
            subtitle1: TextStyle(fontSize: 18, color: ThemeVars().alertDark, fontWeight: FontWeight.bold),
        ),
      ),
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: Init.initialize(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Home();
          }else{
            return SplashScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget{
  List<SavedNotification> notiList = Store.getNotis();
  List<Filter> filterList =  Store.getFilters();
  List<Application> sysAppsList= Store.getApps();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    widget.notiList = Store.getNotis();
    widget.filterList = Store.getFilters();

    ThemeSwitcher().systemNavTheme(context);

    void _navFilterEditor(Filter f) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditorPage(eFilter: f)));
    }

    Future<void> _showMyDialog(int index, Filter f) async{
      return showDialog<void>(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              backgroundColor: Theme.of(context).canvasColor,
              title: Text(
                'Do you want to edit or delete this filter?',
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Delete', style: Theme.of(context).textTheme.subtitle1,),
                  onPressed: (){
                    Store.removeFilter(index);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Edit', style: Theme.of(context).textTheme.headline1,),
                  onPressed: (){
                    _navFilterEditor(f);
                  },
                ),
                TextButton(
                  child: Text('Cancel', style: Theme.of(context).textTheme.headline1,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
      );
    }

    Widget notificationButton(BuildContext context){
      Color iconColor;
      if(widget.notiList.isNull){
        iconColor = Theme.of(context).canvasColor;
      }else if(widget.notiList.length > 0){
        iconColor = Theme.of(context).errorColor;
      }else{iconColor = Theme.of(context).canvasColor;}
      return Container(
        width: 45, height: 45,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Theme.of(context).textTheme.headline1.color),
          color: iconColor,
        ),
        margin: EdgeInsets.fromLTRB(35, 6, 0, 10),
        child: IconButton(
            icon: Icon(Icons.notifications),
            color: Theme.of(context).textTheme.headline1.color,
            onPressed: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(
                builder: (context){
                  return NotificationPage();
                },
              ));
            }),
      );
    }

    Widget getFilterFeed(){
      if(widget.filterList.isNull){
        return emptyHomeBuilder(context);
      }else if(widget.filterList.isBlank){
        return emptyHomeBuilder(context);
      }else return ListView.builder(
          itemCount: widget.filterList.length,
          itemBuilder: (BuildContext context, int index){
            Filter tempF = widget.filterList[index];
            String filterText;
            if(tempF.appList.isNull){
              filterText = "error";
            }else if(tempF.appList.isEmpty){
              filterText = "" + tempF.fmText + ": no apps";
            }else if(tempF.appList.length == 1){
              filterText = "" + tempF.fmText + ": " + tempF.appList[0].appName + '???';
            }else if(tempF.appList.length == 2){
              filterText = "" + tempF.fmText + ": " + tempF.appList[0].appName + ", " + tempF.appList[1].appName + '???';
            }else if(tempF.appList.length >= 3){
              filterText = "" + tempF.fmText + ": " + tempF.appList[0].appName + ", " + tempF.appList[1].appName + ", " + tempF.appList[2].appName + '???';
            }else{
              filterText = "error";
            }
            tempF.writeMode();
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
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                ),
                child: InkWell(
                  splashColor: Theme.of(context).accentColor,
                  onLongPress: (){
                    _showMyDialog(index, tempF);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('#' + tempF.filterName,
                                  style: Theme.of(context).textTheme.headline1
                              ),
                            ],
                          ),
                          Switch(
                            value: tempF.filterState,
                            onChanged: (value){
                              tempF.toggle(value);
                              setState(() {});
                            },
                            activeColor: Theme.of(context).textTheme.headline1.color,
                            activeTrackColor: Theme.of(context).primaryColor,
                            inactiveThumbColor: Theme.of(context).primaryColor,
                            inactiveTrackColor: Theme.of(context).disabledColor,
                          ),
                        ],
                      ),
                      Text(filterText,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                )
            );
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            margin: EdgeInsets.fromLTRB(0, 64, 0, 0),
            child: Column(
              children: [
                Text('Next filter in 26 minutes', style: Theme.of(context).textTheme.headline1,),
                Text('Staff Meeting at 1pm', style: Theme.of(context).textTheme.headline2,)
              ],
            ),
          ),
        ),
      ),
      body: getFilterFeed(),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add_outlined),
          label: Text("New Filter"),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).textTheme.headline1.color, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          onPressed: (){
            List<AppFiltered> aL = [];
            Filter newFilter = new Filter(filterName: '', appList: aL, filterMode: false, filterID: randomInt());
            _navFilterEditor(newFilter);
          },
          backgroundColor: Theme.of(context).accentColor
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(),
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
        ),
        color: Color(0x00ffffff),
        elevation: 0,
        child: Row(children: [
          notificationButton(context),
          Spacer(),
          Container(margin: EdgeInsets.fromLTRB(0, 0, 35, 10),
            width: 45, height: 45,
            decoration: BoxDecoration(border: Border.all(width: 3, color: Theme.of(context).textTheme.headline3.color),),
            child: IconButton(
                icon: Icon(Icons.settings_outlined),
                color: Theme.of(context).textTheme.headline1.color,
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                }),
          ),
        ],
        ),
      ),
    );
  }
}

Widget emptyHomeBuilder(BuildContext context){
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Column(
              children: [
                Text(
                  "You don't have any filters",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "Press '+' to create a new filter",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            )
        ),
      ]
  );
}