import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ruby_china/store/main.dart';
import 'dart:async';
import 'package:ruby_china/api/topics_api.dart';
import 'package:ruby_china/widgets/item.dart';

class WorksPage extends StatefulWidget {
  @override
  _TheState createState() => new _TheState();
}

class _TheState extends State<WorksPage> {

  Future<void> _pullToRefresh() async {
//    curPage = 1;
//    getNewsList(false);
    TopicsApi.fetchWorks();
    return null;
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
        print(obj['works'].error);
//        if(obj['works'].error) {
//          return new Center(
//            child: RaisedButton(
//              child: Text("重新加载"),
//              onPressed: () {
//                TopicsApi.fetchWorks();
//              },
//            ),
//          );
//        }
        if (obj['works'].items == null) {
          return new Center(
            // CircularProgressIndicator是一个圆形的Loading进度条
            child: new CircularProgressIndicator(),
          );
        } else {
          // 有数据，显示ListView
          Widget listView = new ListView.builder(
            itemCount: obj['works'].items.length,
            itemBuilder: (context, i) => Item(data: obj['works'].items[i]),
//            controller: _controller,
          );
          return new RefreshIndicator(
            child: listView, onRefresh: _pullToRefresh);
        }
      }
    );
  }
}