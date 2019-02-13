abstract
class BaseState<T> {
  final T payload;

  BaseState({this.payload});

  @override
  String toString() {

    // print(runtimeType);
    // print(payload);
    return '$runtimeType(${payload?.runtimeType})';
  }

  Object classType() {
    return runtimeType;
  }

//  initialState();
//  copyWith();
}