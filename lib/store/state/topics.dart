import 'package:meta/meta.dart';
import 'package:ruby_china/store/action.dart';
import './base_state.dart';

@immutable
class TopicsState extends BaseState {
  final List items;

  TopicsState({this.items});

//  @override

  static TopicsState initialState() {
    print('initState');
    return TopicsState(
      items: []
    );
  }

  TopicsState copyWith({List items}) {
    return TopicsState(
      items: items ?? this.items
    );
  }
}

class TopicsReducer {
  TopicsState reducer(state, ActionType action) {
    print(action.payload);
    var _action =  action.type.split('.');
    switch (_action[1]) {
      case 'set':
        return state.copyWith(items: action.payload['topics']);
      case 'success':
        List _topics = new List.from(state.items);
        if(_action.contains('addTo')){
          _topics.addAll(action.payload['topics']);
        } else {
          _topics = action.payload['topics'];
        }
        //  _topics = [state.items, action.payload['topics']].expand((x) => x).toList();
        return state.copyWith(items: _topics);  
      default:
        return state;
    }
  }
}