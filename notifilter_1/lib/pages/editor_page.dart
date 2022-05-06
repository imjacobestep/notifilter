import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notifilter_1/main.dart';
import 'package:notifilter_1/models/apps.dart';
import 'package:notifilter_1/models/filters.dart';
import 'package:notifilter_1/tools/theme_switcher.dart';
import 'package:device_apps/device_apps.dart';
import 'package:notifilter_1/tools/central_store.dart' as Store;

class EditorPage extends StatefulWidget{
  Filter eFilter;
  List<Application> sysAppList= Store.getApps();

  EditorPage({this.eFilter});

  @override
  EditorPageState createState() => EditorPageState();

}

class EditorPageState extends State<EditorPage> {

  TextEditingController _nameController;
  List<AppFiltered> tempList = [];

  void createAppList(){
    print("Printing list length" + widget.sysAppList.length.toString());
    widget.sysAppList.forEach((Application) {
      ApplicationWithIcon app = Application;
      AppFiltered tempApp = new AppFiltered(appName: app.appName, packageName: app.packageName, appIcon: MemoryImage(app.icon), isChecked: false);
      tempList.add(tempApp);});
    for(int i = 0; i < tempList.length; i++){
      for(int n = 0; n < widget.eFilter.appList.length; n++){
        if(tempList[i].packageName.compareTo(widget.eFilter.appList[n].packageName) == 0){
          tempList[i].isChecked = true;
        }
      }
    }
    tempList.sort((a, b) {
      return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
    });
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    return true;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
    createAppList();
    _nameController = TextEditingController();
    _nameController.text = widget.eFilter.filterName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }


  Widget topWidget() {
    String filterName = widget.eFilter.filterName;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 80, 0, 10),
      alignment: Alignment.center,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: 250,
          child: TextFormField(
            style: Theme
                .of(context)
                .textTheme
                .headline1,
            controller: _nameController,
            decoration: InputDecoration(
                labelStyle: Theme
                    .of(context)
                    .textTheme
                    .headline1,
                hintStyle: Theme
                    .of(context)
                    .textTheme
                    .headline2,
                alignLabelWithHint: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context)
                        .textTheme
                        .headline1
                        .color)
                ),
                labelText: '#filter name',
                hintText: "currently #$filterName",
                errorStyle: TextStyle(color: Theme
                    .of(context)
                    .errorColor)
            ),
            validator: (v) {
              if (v
                  .trim()
                  .isEmpty) {
                return 'Please enter something';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          //width: 100,
          child: DropdownButton<bool>(
              value: widget.eFilter.filterMode,
              dropdownColor: Theme.of(context).primaryColor,
              items: [
                DropdownMenuItem(
                  child: Text("Allow", style: Theme.of(context).textTheme.headline1,),
                  value: true,
                ),
                DropdownMenuItem(
                  child: Text("Block", style: Theme.of(context).textTheme.headline1,),
                  value: false,
                )
              ],
              onChanged: (bool value) {
                setState(() {
                  widget.eFilter.filterMode = value;
                });
              },
              hint: Text("Select mode", style: Theme
                  .of(context)
                  .textTheme
                  .headline1,)
          ),
        ),
      ],),
    );
  }

  Widget getAppList(){
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index){
            bool checkedVal = tempList[index].isChecked;
            return Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: CheckboxListTile(
                activeColor: Theme.of(context).textTheme.bodyText1.color,
                checkColor: Theme.of(context).accentColor,
                title: Text(tempList[index].appName, style: Theme.of(context).textTheme.bodyText1,),
                value: checkedVal,
                onChanged: (bool newValue) {
                  setState(() {
                    tempList[index].isChecked = newValue;
                    //checkedVal = newValue;
                  });
                },
                secondary: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(60),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    image: new DecorationImage(
                        fit: BoxFit.cover, image: tempList[index]
                        .appIcon),
                  ),
                ),
              ),
            );
          },
        childCount: tempList.length
      ),
    );
  }

  void saveFilter() {
    List<AppFiltered> retList = tempList.where((AppFiltered) => AppFiltered.isChecked).toList( );
    Filter tempFilter = new Filter(filterName: _nameController.text, appList: retList, filterMode: widget.eFilter.filterMode);
    widget.eFilter.update(tempFilter);
    Store.saveFilter(widget.eFilter);
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

    @override
    Widget build(BuildContext context) {

      ThemeSwitcher().systemNavTheme(context);
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: new Container(),
              backgroundColor: Theme.of(context).canvasColor,
             expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: topWidget(),
              ),
            ),
            getAppList(),
            SliverToBoxAdapter(
              child: Container(
                height: 40,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.check),
            label: Text("Save"),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme
                  .of(context)
                  .textTheme
                  .headline1
                  .color, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            onPressed: () {
              saveFilter();
            },
            backgroundColor: Theme
                .of(context)
                .accentColor
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Theme
                    .of(context)
                    .textTheme
                    .headline1
                    .color),
              ),
              margin: EdgeInsets.fromLTRB(35, 6, 0, 10),
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Theme
                      .of(context)
                      .textTheme
                      .headline1
                      .color,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
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
