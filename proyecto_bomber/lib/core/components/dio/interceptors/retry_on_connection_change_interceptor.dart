// import 'package:dio/dio.dart';

// import 'connectivity_interceptor.dart';

// class RetryOnConnectionChangeInterceptor extends Interceptor {
//   // final ConnectivityInterceptor requestRetrier;

//   RetryOnConnectionChangeInterceptor({
//     required this.requestRetrier,
//   });

//   @override
//   onError(DioException err, ErrorInterceptorHandler handler) {
//     if (_shouldRetry(err)) {
//       try {
//         // TESTAR NO MOBILE
//         // TESTAR NO MOBILE
//         // TESTAR NO MOBILE
//         // TESTAR NO MOBILE
//         // TESTAR NO MOBILE
//         requestRetrier.scheduleRequestRetry(err.requestOptions);
//       } catch (e) {
//         DioException error = DioException(error: e, requestOptions: err.requestOptions);
//         handler.next(error);
//       }
//     }
//     return handler.next(err);
//   }

//   bool _shouldRetry(DioException err) {
//     // if (kIsWeb) {
//     // ignore: deprecated_member_use
//     return err.type == DioErrorType.unknown && err.error != null;
//     // } else {
//     //   return err.type == DioErrorType.other &&
//     //       err.error != null &&
//     //       err.error is SocketException;
//     // }
//   }
// }
