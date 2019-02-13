import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ruby_china/store/main.dart';
import 'package:ruby_china/api/nodes_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MorePage extends StatefulWidget {
  @override
  _TheState createState() => new _TheState();
}

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

class _TheState extends State<MorePage> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector <MainState, Map> (
      converter: (store) {
        return {
          'two': store.state.two,
          'nodes': store.state.subState['nodes']
        };
      },
      onInit: (store) => NodesApi.fetchNodes(),
      builder: (context, obj) {
        return StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: obj['nodes'].items.length,
          itemBuilder: (BuildContext context, int index) => new Container(
              color: Colors.redAccent[100],
              child: Center(
                child:  Text(obj['nodes'].items[index]['name']),
                ),
              ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
      }
    );
  }
}