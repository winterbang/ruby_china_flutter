import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import 'package:ruby_china/store/main.dart';
// import 'package:ruby_china/store/action.dart';
import 'package:ruby_china/api/topics_api.dart';
// import 'package:ruby_china/widgets/item.dart';
import 'package:ruby_china/pages/detail_page.dart';
import 'package:ruby_china/pages/partials/filter.dart';

class ListPage extends StatefulWidget {
  @override
  _TheState createState() => new _TheState();
}

class _TheState extends State<ListPage> {
  ScrollController _controller;
  num curPage = 1;

  _TheState() {
    _controller = new ScrollController();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        // load next page
        TopicsApi.fetchTopics({'offset': curPage*20});
        curPage++;
      }
    });
  }
  Future<void> _pullToRefresh() async {
    TopicsApi.fetchTopics({});
    return null;
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          // opacity: isPerformingRequest ? 1.0 : 0.0,
          opacity: 1.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    return StoreConnector <MainState, Map> (
      converter: (store) {
        return {
          'nodes': store.state.subState['nodes'],
          'topics': store.state.subState['topics']
        };
      },
      onInit: (store) => TopicsApi.fetchTopics({}),
      builder: (context, obj) {
        return Scaffold (
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: new Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null,
            ),
            title: GestureDetector(
              child: Text('发现'),
              onDoubleTap: () {
                // _scrollController.animateTo(
                //   0.0,
                //   curve: Curves.easeOut,
                //   duration: const Duration(milliseconds: 300),
                // )
                print('click appbar twice');
              }
            ),
            actions: <Widget>[
              IconButton(
                icon: new Icon(Icons.filter_list),
                tooltip: 'Navigation menu',
                onPressed: () {
                  // _scaffoldKey.currentState.openDrawer(); // left side
                  _scaffoldKey.currentState.openEndDrawer(); // right side
                },
              )
              // PopupMenuButton<String>(
              //   onSelected: (String value) {
              //     // setState(() {
              //     //   _bodyStr = value;
              //     // });
              //   },
              //   itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              //     new PopupMenuItem<String>(
              //       value: '选项一的值',
              //       child: new Text('选项一')
              //     ),
              //     new PopupMenuItem<String>(
              //       value: '选项二的值',
              //       child: new Text('选项二')
              //     )
              //   ]
              // )
            ],
          ),
          body: Builder (
            builder: (BuildContext context) {
              if (obj['topics'].items.length == 0) {
                return new Center(
                  // CircularProgressIndicator是一个圆形的Loading进度条
                  child: new CircularProgressIndicator(),
                );
              } else {
                // 有数据，显示ListView
                Widget listView = ListView.builder(
                  itemCount: obj['topics'].items.length + 1,
                  itemBuilder: (context, i) {
                    if (i == obj['topics'].items.length) {
                      return _buildProgressIndicator();
                    } else {
                      // return Item(data: obj['topics'].items[i]);
                      return Container(
                        padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300],
                              width: 1.0,
                            )
                          )
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.brown.shade800,
                            backgroundImage: NetworkImage(obj['topics'].items[i]['user']['avatar_url']),
                            // child: ,
                          ),
                          title: Text(obj['topics'].items[i]['title']),
                          subtitle: Row(
                            children: [
                              Text(obj['topics'].items[i]['user']['name'] ?? obj['topics'].items[i]['user']['login']),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: Text(obj['topics'].items[i]['node_name']),
                              ),
                              // Text(obj['topics'].items[i]['replied_at'])
                            ]
                          ),  
                          // enabled: _act == 2,
                          // isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            // crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(obj['topics'].items[i]['likes_count'].toString()),
                              Icon(Icons.keyboard_arrow_right),
                            ]
                          ),
                          // SizedBox(
                          //   width: 40.0, 
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: <Widget>[
                          //       Text(obj['topics'].items[i]['replies_count'].toString()),
                          //       Icon(Icons.keyboard_arrow_right)
                          //     ],
                          //   )
                          // ),
                          // Text(obj['topics'].items[i]['likes_count'].toString()),
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       // Text(obj['topics'].items[i]['likes_count'].toString()),
                          //       Icon(Icons.keyboard_arrow_right)]
                          //   ),
                          // ),
                          // dense: true,
                          onTap: () {
                            print('click ${obj['topics'].items[i]['title']}');
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (ctx) => DetailPage(id: obj['topics'].items[i]['id'], title: obj['topics'].items[i]['title'])
                            ));
                          },
                          onLongPress: () {
                            print('long press');
                            showCupertinoModalPopup<String>(
                              context: context,
                              builder: (BuildContext context) => CupertinoActionSheet(
                                // title: const Text('标题'),
                                // message: const Text('介绍说明'),
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    child: const Text('Item1'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Profiteroles');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Item2'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Profiteroles');
                                    },
                                  )
                                ]
                              ),
                            ).then((String value) {
                              if (value != null) {
                                print(value);
                              }
                            });
                          },
                        ),
                      );
                    }
                  }, 
                  controller: _controller,
                );
                return new RefreshIndicator(
                  child: listView, onRefresh: _pullToRefresh
                );
              }
            }
          ),
          // drawer: MorePage(), // left
          endDrawer: FilterDrawer() 
        );
      }
    );
  }
}