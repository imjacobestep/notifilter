import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).canvasColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              child: Image(image: AssetImage('assets/icon.png'), height: 50, width: 50,),
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
            ),
          ],
        ),
      )
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color: Theme.of(context).canvasColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Loading",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
              ),
            ],
          ),
        )
    );
  }
}