import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DateInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timer = DateTime.now();

    var time = timer.timeZoneOffset.toString().split(":");

    String horas = '';
    if (time[0].length < 3) {
      horas = "${time[0].substring(0, 1)}0${time[0].substring(1, 2)}";
    } else {
      horas = time[0];
    }

    String minutes = time[1];

    options.headers['timeOffSet'] = "$horas:$minutes";

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final start = DateTime.parse(response.requestOptions.extra['start_time']);
    final totalExecution = DateTime.now().difference(start);

    if (kDebugMode) {
      print("Tempo de execução ${totalExecution.inMilliseconds} milisegundos.");
    }
    response.extra['execution_time'] = "${totalExecution.inMilliseconds}";
    handler.next(response);
  }
}
