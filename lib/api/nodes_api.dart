import 'package:ruby_china/api/base.dart';
import 'package:ruby_china/store/action.dart';

class NodesApi {
  static fetchNodes() {
    final apiFuture = Services.rest.get('/api/v3/nodes.json');
    Services.asyncRequest(
      apiFuture,
      ActionType(type: 'loading'),
      (json) => ActionType(payload: json, type: 'nodes.success'),
      (errorInfo) => ActionType(payload: errorInfo, type: 'error')
    );
  }
}