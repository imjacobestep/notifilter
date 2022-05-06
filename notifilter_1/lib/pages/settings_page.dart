import 'package:flutter/material.dart';
import 'package:notifilter_1/tools/theme_switcher.dart';
import 'package:share/share.dart';
class SettingsPage extends StatefulWidget{

  final int index;

  SettingsPage({Key key, this.index}) : super(key: key);
  @override
  SettingsPageState createState() => SettingsPageState();

}

class SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin{

  sharePage() async{
    Share.share('share text');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeSwitcher().systemNavTheme(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            margin: EdgeInsets.fromLTRB(0, 72, 0, 0),
            child: Column(
              children: [
                Text('Settings', style: Theme.of(context).textTheme.headline1,),
                //Text('Staff Meeting at 1pm', style: Theme.of(context).textTheme.headline2,)
              ],
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: getSettings(context),
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
                  Navigator.pop(context);
                }
            ),
          ),
          Spacer(),
        ],
        ),
      ),
    );
  }

  Widget getSettings(BuildContext context){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Row(
            children: [
              Text('Line 1', style: Theme.of(context).textTheme.headline1,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Row(
            children: [
              Text('Line 2', style: Theme.of(context).textTheme.headline1,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Row(
            children: [
              Text('Line 3', style: Theme.of(context).textTheme.headline1,),
            ],
          ),
        ),
      ],
    );
  }

}