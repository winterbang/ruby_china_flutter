import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Item extends StatefulWidget {
  final Map data;

  Item({this.data});

  @override
  _TheState createState() => new _TheState();
}

class _TheState extends State<Item> {
  TextStyle subtitleStyle = new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: new Border(
            bottom: BorderSide(
              width: 1.0,
              color: Color(0xFFECECEC)
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFECECEC),
                image: new DecorationImage(
                  image: new NetworkImage(data['user']['avatar_url']), fit: BoxFit.cover),
                border: new Border.all(
                  color: const Color(0xFFECECEC),
                  width: 2.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data['title']),
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                      child: Text(data['user']['name'] ?? data['user']['login']),
                    )
                  ],
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(data['node_name']),
                  Text(data['likes_count'].toString())
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        print('click the topic ${data['title']}');
        showCupertinoDialog<String>(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Discard draft?'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Discard'),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context, 'Discard');
                },
              ),
              CupertinoDialogAction(
                child: const Text('Cancel'),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
              ),
            ],
          ),
        ).then((String value) {
          if (value != null) {
            print(value);
          }
        });
//        Navigator.of(context).push(new MaterialPageRoute(
//          builder: (ctx) => new NewsDetailPage(id: itemData['detailUrl'])
//        ));
      },
    );
  }

}