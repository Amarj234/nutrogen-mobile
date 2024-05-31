import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/utils/app_log.dart';

class ApiService {
  final Dio dio;
  const ApiService({required this.dio});

  Future<T> call<T>({
    required String endPoint,
    T Function(Map<String, dynamic>)? fromJson,
    String method = 'post',
    dynamic data,
    Map<String, String>? query,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.request(
        endPoint,
        data: data,
        queryParameters: query,
        options: Options(
          method: method,
          headers: {
            'x-access-token':
                Hive.box(AppConstants.appName).get(AppConstants.tokenKey),
          },
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return fromJson?.call(response.data) ?? response.data;
    } on DioException catch (error) {
      if (error.response?.statusCode == 400 ||
          error.response?.statusCode == 401 ||
          error.response?.statusCode == 403) {
        _unauthorizedUser();
      }
      throw '${error.message ?? error.error}';
    } catch (error) {
      throw '$error';
    }
  }

  Future download({
    required String endPoint,
    required String filePath,
    String method = 'post',
    dynamic data,
    Map<String, String>? query,
    CancelToken? cancelToken,
    String leangthHeader = Headers.contentLengthHeader,
    bool deleteOnError = true,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.download(
      endPoint,
      filePath,
      data: data,
      queryParameters: query,
      options: Options(
        method: method,
        headers: {
          'x-access-token':
              Hive.box(AppConstants.appName).get(AppConstants.tokenKey),
        },
      ),
      cancelToken: cancelToken,
      lengthHeader: leangthHeader,
      deleteOnError: deleteOnError,
      onReceiveProgress: onReceiveProgress,
    );
  }

  void _unauthorizedUser() {}
}

BaseOptions get baseOption => BaseOptions(
      sendTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      baseUrl: AppConstants.baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

RetryInterceptor retryInterceptor(Dio dio) => RetryInterceptor(
      dio: dio,
      retries: 3,
      logPrint: AppLog.e,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 3),
      ],
    );

InterceptorsWrapper get interceptor => InterceptorsWrapper(
      onRequest: (options, handler) {
        options.extra['request_call_time'] =
            DateTime.now().millisecondsSinceEpoch;
        handler.next(options);
      },
      onResponse: (response, handler) {
        AppLog.s(prepareLog(response.requestOptions, response), name: 'DIO');
        handler.next(response);
      },
      onError: (dioError, handler) {
        AppLog.e(
          prepareLog(dioError.requestOptions, dioError.response),
          error: dioError,
          stackTrace: dioError.stackTrace,
          name: 'DIO',
        );

        handler.next(dioError);
      },
    );
