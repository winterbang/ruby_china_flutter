import 'package:ruby_china/api/base.dart';
import 'package:ruby_china/store/action.dart';

class TopicsApi {

  // type (String) - 排序类型, default: last_actived, %w(last_actived recent no_reply popular excellent)
  // node_id (Integer) - 节点编号，如果有给，就会只去节点下的话题
  // offset (Integer) - default: 0
  // limit (Integer) - default: 20, range: 1..150
  static fetchTopics(params) {
    final apiFuture = Services.rest.get('/api/v3/topics.json', data: params ?? {});
    var _type = params['offset'] != null ? 'topics.success.addTo' : 'topics.success';
    Services.asyncRequest(
      apiFuture,
      ActionType(type: 'loading'),
        (json) => ActionType(payload: json, type: _type),
        (errorInfo) => ActionType(payload: errorInfo, type: 'topics.error')
    );
  }

  static fetchWorks() {
    final apiFuture = Services.rest.get('/api/v3/topics.json?node_id=25');
    Services.asyncRequest(
      apiFuture,
      ActionType(type: 'loading'),
        (json) => ActionType(payload: json, type: 'works.success'),
        (errorInfo) => ActionType(payload: errorInfo, type: 'works.error')
    );
  }

  static detail(id, callback) {
    final apiFuture = Services.rest.get('/api/v3/topics/$id.json');
    Services.baseRequest(apiFuture, callback);
  }

  static replies(id, callback) {
    final apiFuture = Services.rest.get('/api/v3/topics/$id/replies.json');
    Services.baseRequest(apiFuture, callback);
  }
}