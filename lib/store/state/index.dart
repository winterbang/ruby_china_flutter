import './nodes.dart';
import './topics.dart';
import './works.dart';

Map stateIndex() {
  return {
    'nodes': NodesState.initialState(),
    'topics': TopicsState.initialState(),
    'works': WorksState.initialState()
  };
}

Map reducerIndex() {
  return {
    'nodes': NodesReducer(),
    'topics': TopicsReducer(),
    'works': WorksReducer()
  };
}