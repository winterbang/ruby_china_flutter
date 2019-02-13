import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ruby_china/store/main.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:html/dom.dart' as dom;
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:ruby_china/api/topics_api.dart';

class DetailPage extends StatefulWidget {
  final num id;
  final title;
  DetailPage({@required this.id, this.title});

  @override
  _TheState createState() => new _TheState();
}

class _TheState extends State<DetailPage> with SingleTickerProviderStateMixin{
  bool isLoading = false;
  Map  topic = {};
  Map  meta = {};
  List replies = [];
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
    setState(() {
      isLoading = true;  
    });
    TopicsApi.detail(widget.id, (resp){
      print(resp);
      setState(() {
        isLoading = false;
        topic = resp.data['topic']; 
        meta = resp.data['meta']; 
      });
    });
    TopicsApi.replies(widget.id, (resp){
      print(resp);
      setState(() {
        isLoading = false;
        replies = resp.data['replies']; 
      });
    });

  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }
//   Future<Null> _pullToRefresh() async {
// //    curPage = 1;
// //    getNewsList(false);
//     TopicsApi.fetchWorks();
//     return null;
//   }

  @override
  Widget build(BuildContext context) {
    return StoreConnector <MainState, Map> (
      converter: (store) {
        return {
          'two': store.state.two,
          'works': store.state.subState['works']
        };
      },
      // onInit: (store) => TopicsApi.detail(widget.id),
      builder: (context, obj) {
        return Scaffold(
          body: new NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: new Text(widget.title),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    tabs: <Tab>[
                      new Tab(text: "帖子"),
                      new Tab(text: "回复"),
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: TabBarView(
              
              children: <Widget>[
                Scrollbar(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: Html(
                      data: topic['body_html'] ?? '',
                      // onLinkTap: (url) {
                      //   print(url);
                      //   // open url in a webview
                      // },
                      // defaultTextStyle: TextStyle(
                      //   fontFamily: 'serif',
                      //   fontSize: 16.0,
                      //   height: 1.2
                      // )
                    ),  
                  )
                ),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: replies.length,
                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.brown.shade800,
                            backgroundImage: NetworkImage(replies[i]['user']['avatar_url']),
                            // child: ,
                          )
                        ],
                      ),
                      title: Text(replies[i]['body']),
                      subtitle: Container(
                        child: Text(replies[i]['user']['name']),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          //   child: Text(replies[i]['']),
                          // ),
                          // Text(obj['topics'].items[i]['replied_at'])
                        
                      ), 
                      
                      // enabled: _act == 2,
                      // isThreeLine: true,
                      // trailing: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   // crossAxisAlignment: CrossAxisAlignment.baseline,
                      //   textBaseline: TextBaseline.alphabetic,
                      //   children: <Widget>[
                      //     Text(obj['topics'].items[i]['likes_count'].toString()),
                      //     Icon(Icons.keyboard_arrow_right),
                      //   ]
                      // )
                    );
                  }
                )
              ],
              controller: _tabController,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.create),
            tooltip: "Hello",
            foregroundColor: Colors.white,
            backgroundColor: Colors.redAccent[100],
            heroTag: null,
            elevation: 7.0,
            highlightElevation: 14.0,
            onPressed: () {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("FAB is Clicked"),
              ));
            },
            mini: false,
            shape: new CircleBorder(),
            isExtended: false,
          ),
          bottomNavigationBar: BottomAppBar(   
            child: Container(
              height: 60.0,
              child: Row (
                children: [
                  Text('喜欢'),
                  Text('收藏')
                ]  
              ),
            ),
          ),
        
        );
      }
    );
  }
}