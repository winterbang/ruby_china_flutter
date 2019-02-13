import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './store/main.dart';
import 'package:flutter/foundation.dart';
import './pages/works_page.dart';
import './pages/list_page.dart';
import './pages/my_page.dart';
import './pages/more_page.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider <MainState>(
      store: StoreContainer.global,
      child: MaterialApp(
        title: 'Ruby China',
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          primarySwatch: Colors.red,
        ),
        home: HomePage(title: 'Ruby China'),
        initialRoute: '/',
        // supportedLocales: const <Locale>[
        //   Locale('en', 'US'),
        //   Locale('es', 'ES'),
        // ],
        routes: <String, WidgetBuilder>{ // 路由
          '/MainPage': (BuildContext context) => Text('test')
        },
        // checkerboardRasterCacheImages: true,
        // debugShowMaterialGrid: true,
        // showPerformanceOverlay: true,
        // checkerboardOffscreenLayers: true,
        // showSemanticsDebugger: true,
        // debugShowCheckedModeBanner: false

      )
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _body;
  int _tabIndex = 3;
  List<Widget> pages = [ListPage(), WorksPage(), MorePage(), MyPage()];

  void initData() {
    // pages.insert(0, ListPage());
    _body = IndexedStack(
      alignment: const Alignment(0.6, 0.6),
      children: pages,
      index: _tabIndex,
    );
  }

  void _onItemTapped(int index) {
    print(index);
    // var _pages = pages;
    // if(_pages[index] == null){
    //   switch(index){
    //     case 1:
    //       return _pages.insert(index, WorksPage());
    //     case 2:
    //       return _pages.insert(index, MorePage());
    //     case 3:
    //       return _pages.insert(index, MyPage());
    //   }    
    // }

    setState(() {
      _tabIndex = index;
      pages = pages;
    });
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
//      backgroundColor: Colors.red[50],
      // appBar: AppBar(
      //   title: GestureDetector(
      //     child: Text(widget.title),
      //     onDoubleTap: () {
      //       // _scrollController.animateTo(
      //       //   0.0,
      //       //   curve: Curves.easeOut,
      //       //   duration: const Duration(milliseconds: 300),
      //       // )
      //       print('click appbar twice');
      //     }
      //   ),
      //   actions: <Widget>[
      //     PopupMenuButton<String>(
      //       onSelected: (String value) {
      //         // setState(() {
      //         //   _bodyStr = value;
      //         // });
      //       },
      //       itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
      //         new PopupMenuItem<String>(
      //           value: '选项一的值',
      //           child: new Text('选项一')
      //         ),
      //         new PopupMenuItem<String>(
      //           value: '选项二的值',
      //           child: new Text('选项二')
      //         )
      //       ]
      //     )
      //   ],
      // ),
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('发现'),
            icon: Icon(Icons.home), 
          ),
          BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('招聘')),
          BottomNavigationBarItem(
            title: Text('发现'),
            icon: new Stack(
              children: <Widget>[
                new Icon(Icons.notifications_active),
                new Positioned(  // draw a red marble
                  top: 0.0,
                  right: 0.0,
                  child: new Icon(Icons.brightness_1, size: 12.0, 
                    color: Colors.redAccent),
                )
              ]
            ),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('我'))
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        fixedColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
