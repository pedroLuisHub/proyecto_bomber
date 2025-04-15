import 'dart:developer';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // late String? sessionID;
    // sessionID =
    //     await LocalStorageService.instance.get(key: KeyConstants.SESSION_ID);

    // options.headers['sessionID'] = sessionID;
    options.headers['Access-Control-Allow-Origin'] = "*";
    options.headers['Access-Control-Allow-Credentials'] = true;
    options.headers['Access-Control-Allow-Headers'] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    options.headers['Access-Control-Allow-Methods'] = "GET, PUT, POST, OPTIONS";
    log('REQUEST AUTH[${options.method}] => PATH: ${options.path}');
    
    handler.next(options);
  }
}
