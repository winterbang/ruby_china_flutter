import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:ruby_china/store/state/index.dart';

class StoreContainer {
  static final Store<MainState> global = reduxStore();

  static dispatch(dynamic action) => global.dispatch(action);
}

MainState reduxReducer(MainState state, action) => mainReducer(state, action);
Store reduxStore() => Store<MainState>(reduxReducer, initialState: MainState.initialState(), distinct: true);

@immutable
class MainState {
  final one;
  final two;
  final loading;
  final subState;


  MainState({
   this.one,
   this.two,
   this.loading,
   this.subState,
  });

  static
  MainState initialState() {
    Map _subState = stateIndex();

    return MainState(
      one: 1,
      two: 2,
      loading: false,
      subState: _subState
    );
  }

  MainState copyWith({num one, num two, bool loading, Map subState}) {
    return MainState(
      one: one ?? this.one,
      two: two ?? this.two,
      loading: loading ?? this.loading,
      subState: subState ?? this.subState
    );
  }
}

MainState mainReducer(pState, pAction) {
  var _action =  pAction.type.split('.');
  print('_action========= $_action');
  var newSubState;
  if(_action.length >= 2) {
    var namespace = _action[0];
    // var method = _action[1];
    var rdc = reducerIndex()[namespace];

    newSubState = rdc.reducer(pState.subState[namespace], pAction);

    Map _subState = pState.subState;
    _subState[namespace] = newSubState;
    var newState = pState.copyWith(subState: _subState);

    return newState;
  } else {
    switch (pAction.type) {
      case 'add':
        return pState.copyWith(two: pState.two + 1);
      case 'success':
        return pState.copyWith(items: pAction.payload['nodes']);
      case 'error':
        return pState;
      case 'loading':
        return pState.copyWith(loading: true);
      default:
        return pState;
    }
  }
}
