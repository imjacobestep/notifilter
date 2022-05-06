import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:notifilter_1/models/notifications.dart';
import 'package:notifilter_1/tools/theme_switcher.dart';
import 'package:notifilter_1/tools/central_store.dart' as Store;
import '../main.dart';

class NotificationPage extends StatefulWidget{

  List<SavedNotification> nL = Store.getNotis();
  NotificationPage();

  @override
  NotificationPageState createState() => NotificationPageState();

}

class NotificationPageState extends State<NotificationPage>{

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    return true;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeSwitcher().systemNavTheme(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          flexibleSpace: Container(
            margin: EdgeInsets.fromLTRB(0, 64, 0, 0),
            child: Column(
              children: [
                Text('You have ' + widget.nL.length.toString() + " notifications", style: Theme.of(context).textTheme.headline1,),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: widget.nL.isEmpty ? emptyHomeBuilder(context) : ListView.builder(
            itemCount: widget.nL.length,
            itemBuilder: (BuildContext context, int index){
              SavedNotification temp = widget.nL[index];
              return Dismissible(
                background: Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.delete, color: Theme.of(context).textTheme.bodyText1.color,),
                      ),
                      Text('Dismiss', style: Theme.of(context).textTheme.bodyText1,),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Dismiss', style: Theme.of(context).textTheme.bodyText1,),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.delete, color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                ),
                key: UniqueKey(),
                onDismissed: (direction){
                  setState((){
                    widget.nL.removeAt(index);
                  });
                },
                child: Container(
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
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(temp.bigIcon, size: 26,),
                          SizedBox(width: 8,),
                          Text(temp.appName, style: Theme.of(context).textTheme.bodyText2), //NAME
                          SizedBox(width: 8,),
                          Text(temp.time, style: Theme.of(context).textTheme.bodyText2), //TIME
                        ],),
                        SizedBox(height: 4,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(temp.bigText, style: Theme.of(context).textTheme.headline3), //BIG TEXT
                          Text(temp.smallText, style: Theme.of(context).textTheme.bodyText1), //SMALL TEXT
                        ],)
                      ],)
                ),
              );
            }
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).canvasColor,
        elevation: 0,
        child: Row(children: [
          Container(
            width: 45, height: 45,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Theme.of(context).textTheme.headline1.color),
            ),
            margin: EdgeInsets.fromLTRB(35, 6, 0, 10),
            child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).textTheme.headline1.color,
                onPressed: (){
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(
                    builder: (context){
                      return Home();
                    },
                  ));
                }
            ),
          ),
          Spacer(),
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
                  "You don't have any notifications",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "Go back to create a new filter",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            )
        ),
      ]
  );
}