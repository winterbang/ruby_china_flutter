import 'package:meta/meta.dart';
import 'package:ruby_china/store/action.dart';
import 'package:ruby_china/store/state/base_state.dart';

@immutable
class NodesState extends BaseState {
  final items;

  NodesState({this.items});

//  @override

  static NodesState initialState() {
    print('initState');
    return NodesState(
      items: []
    );
  }

  NodesState copyWith({List items}) {
    return NodesState(
      items: items ?? this.items
    );
  }
}

class NodesReducer {
  NodesState reducer(state, ActionType action) {
    print(action.payload);

    var _action =  action.type.split('.');
    switch (_action[1]) {
      case 'set':
        return state.copyWith(items: action.payload['nodes']);
      case 'success':
        NodesState newState =  state.copyWith(items: action.payload['nodes']);
        print(newState.items);
        print('nodes new_state=======');
        return newState;
      default:
        return state;
    }
  }
}