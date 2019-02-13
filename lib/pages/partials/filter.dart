import 'package:flutter/material.dart';
class FilterDrawer extends StatefulWidget {
  @override
  _TheState createState() => new _TheState();
}

class _TheState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, //纵轴三个子widget
                  childAspectRatio: 1.0 //宽高比为1时，子widget
              ),
              children:<Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast)
              ]
            ),
          )
        ],
      ),
    );
  }
}