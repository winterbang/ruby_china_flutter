import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ruby_china/store/main.dart';
import 'package:ruby_china/util/datetime_util.dart';
import 'package:ruby_china/store/action.dart';
//import './oauth2_client.dart';

class Services {
  static final defaultCode = '-1';
  static final requestMinThreshold = 500;
  static final _options = Options(
    baseUrl: 'https://ruby-china.org',
    connectTimeout: 10000,
    receiveTimeout: 10000,
    contentType: ContentType.json,
    responseType: ResponseType.JSON,
//    headers: {
//      'Accept-Charset': 'utf-8, iso-8859-1;q=0.5'
//    }
  );

  static final rest = Dio(_options);

  static
  asyncRequest(
      Future<Response> apiFuture,
      ActionType request,
      ActionType Function(dynamic) success,
      ActionType Function(dynamic) failure,
      ) async {
    // request
    StoreContainer.global.dispatch(request);
    final requestBegin = DateTimeUtil.dateTimeNowMilli();

//    var client =  await OauthClient.getClient();
//    var result = client.read('https://ruby-china.org/api/v3/nodes');
//    print('result ======= $request');
    try {
      final response = await apiFuture;
//      print('response========== $response');
       final requestEnd = DateTimeUtil.dateTimeNowMilli();
       final requestSpend = requestEnd - requestBegin;
       if (requestSpend < requestMinThreshold) {
         await Future.delayed(Duration(milliseconds: requestMinThreshold - requestSpend)); // 请求返回太快，页面有点卡顿，有点尴尬 todo
       }
      // success
      StoreContainer.global.dispatch(success(response.data));
    } on DioError catch (error) {
      print('error==========: $error');
      print(error.type);
      if(error.type == DioErrorType.CONNECT_TIMEOUT) {
        print('请求超时');
      }
      var message = '';
      var code = '-1';
      var url = '';
      if (error.response != null) {
        var errorData = error.response.data;
         List messageList = errorData is Map<String, dynamic>
             ? ((errorData['msg']) ?? [])
             : [];
         messageList
             .forEach((item) => message = message + item.toString() + ' ');
        code = error.response.statusCode.toString();
        url = error.response.request.baseUrl + error.response.request.path;
      } else {
        message = error.message;
      }
      print(code);
      print(url);
      // final model = RequestFailureInfo(
      //   errorCode: code,
      //   errorMessage: message,
      //   dateTime: DateTimeUtil.dateTimeNowIso());
      //   // failure
      // StoreContainer.global.dispatch(failure(model));
      StoreContainer.global.dispatch(failure({'errorCode': code, 'errorMessage': message, 'dateTime': DateTimeUtil.dateTimeNowIso()}));
    }
  }

  static baseRequest (
    Future<Response> apiFuture,
    Function callback
  ) async {
    try{
      final response = await apiFuture;
      callback(response);
    } on DioError catch (error) {
      print('error==========: $error');
    }
  }
}