import 'package:meta/meta.dart';
import 'package:ruby_china/store/action.dart';
import './base_state.dart';

@immutable
class WorksState extends BaseState {
  final items;
  final bool error;

  WorksState({this.items, this.error});

//  @override

  static WorksState initialState() {
    print('initState');
    return WorksState(
      items: [],
      error: false
    );
  }

  WorksState copyWith({List items, bool error}) {
    return WorksState(
      items: items ?? this.items,
      error: error ?? this.error
    );
  }
}

class WorksReducer {
  WorksState reducer(state, ActionType action) {
    print(action.payload);
    var _action =  action.type.split('.');
    switch (_action[1]) {
      case 'set':
        return state.copyWith(items: action.payload['topics']);
      case 'success':
        return state.copyWith(items: action.payload['topics']);
      case 'error':
        return state.copyWith(error: true);
      default:
        return state;
    }
  }
}