import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ruby_china/store/main.dart';

import 'package:ruby_china/api/topics_api.dart';

class MyPage extends StatefulWidget {
  @override
  _TheState createState() => new _TheState();
}

class _TheState extends State<MyPage> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector <MainState, Map> (
      converter: (store) {
        print(store.state.subState['works'].items);
        return {
          'two': store.state.two,
          'works': store.state.subState['works']
        };
      },
      onInit: (store) => TopicsApi.fetchWorks(),
      builder: (context, obj) {
        int _act = 1;
        return ListView(
          children: <Widget>[
            new ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.brown.shade800,
                child: Text('AH'),
              ),
              title: new Text('Maps'),
              subtitle: Text('The airplane is only in Act II.'),
              enabled: _act == 2,
              isThreeLine: true,
              trailing: Icon(Icons.keyboard_arrow_right),
              // dense: true,
            ),
            new ListTile(
              leading: new Icon(Icons.photo_album),
              title: new Text('Album'),
            ),
            new ListTile(
              leading: new Icon(Icons.phone),
              title: new Text('Phone'),
            ),
            Center(
              child: Container(
                margin: new EdgeInsets.symmetric(vertical: 10.0),
                height: animation.value,
                width: animation.value,
                child: new FlutterLogo(),
              )
            )
          ],
        );
      }
    );
  }
}