class ActionType<T> {
  final T payload;
  final type;

  ActionType({this.payload, this.type});

  @override
  String toString() => '$runtimeType(${payload?.runtimeType})';
}

class VoidAction extends ActionType<void> {}