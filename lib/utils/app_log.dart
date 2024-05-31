import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class AppLog {
  static void s(
    String message, {
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    try {
      message =
          const JsonEncoder.withIndent('   ').convert(jsonDecode(message));
    } catch (_) {}

    log(
      '\x1B[32m$message\x1B[0m',
      name: '✅ ${name ?? 'Success'}',
      error: error,
      stackTrace: stackTrace,
      level: 50,
    );
  }

  static void i(
    String message, {
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    try {
      message =
          const JsonEncoder.withIndent('   ').convert(jsonDecode(message));
    } catch (_) {}

    log(
      '\x1B[34m$message\x1B[0m',
      name: 'ℹ️ ${name ?? 'Info'}',
      error: error,
      stackTrace: stackTrace,
      level: 100,
    );
  }

  static void w(
    String message, {
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    try {
      message =
          const JsonEncoder.withIndent('   ').convert(jsonDecode(message));
    } catch (_) {}

    log(
      '\x1B[33m$message\x1B[0m',
      name: '❗ ${name ?? 'Warning'}',
      error: error,
      stackTrace: stackTrace,
      level: 150,
    );
  }

  static void e(
    dynamic message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    try {
      message =
          const JsonEncoder.withIndent('   ').convert(jsonDecode(message));
    } catch (_) {}

    log(
      '\x1B[31m$message\x1B[0m',
      name: '❌ ${name ?? 'Error'}',
      error: error,
      stackTrace: stackTrace,
      level: 200,
    );
  }
}

const _includeRequest = true;
const _includeRequestHeaders = true;
const _includeRequestQueryParams = true;
const _includeRequestBody = true;
const _includeResponse = true;
const _includeResponseHeaders = false;
const _includeResponseBody = true;

String prepareLog(RequestOptions? requestOptions, Response? response) {
  var requestString = '', responseString = '';
  if (_includeRequest) {
    requestString = '\n-> REQUEST -> ';
    requestString +=
        '${requestOptions?.method ?? ''} ${requestOptions?.baseUrl}${requestOptions?.path}\n\n';
    if (_includeRequestHeaders) {
      for (final header in (requestOptions?.headers ?? {}).entries) {
        requestString += '${header.key}: ${header.value}\n';
      }
    }

    if (_includeRequestQueryParams &&
        requestOptions?.queryParameters != null &&
        requestOptions!.queryParameters.isNotEmpty) {
      requestString += '\n${getQueryParams(requestOptions.queryParameters)}';
    }

    if (_includeRequestBody && requestOptions?.data != null) {
      requestString +=
          '\n${getBody(requestOptions?.data, requestOptions?.contentType)}';
    }

    requestString += '\n\n';
  }

  if (_includeResponse && response != null) {
    responseString =
        '-> RESPONSE -> [${response.statusCode}/${response.statusMessage}] '
        '${requestOptions?.extra['request_call_time'] != null ? '[Time elapsed: ${DateTime.now().millisecondsSinceEpoch - requestOptions?.extra['request_call_time']} ms]' : ''}\n';

    if (_includeResponseHeaders) {
      for (final header in response.headers.map.entries) {
        responseString += '${header.key}: ${header.value}\n';
      }
    }

    if (_includeResponseBody && response.data != null) {
      responseString +=
          '\n${getBody(response.data, response.headers.value('content-type'))}\n';
    }
  }

  return requestString + responseString;
}

String getBody(dynamic data, String? contentType) {
  final type = contentType?.toLowerCase();
  if (type?.contains('application/json') == true ||
      type?.contains('application/x-www-form-urlencoded') == true) {
    const encoder = JsonEncoder.withIndent('   ');
    dynamic jsonBody;
    if (data is String) {
      jsonBody = jsonDecode(data);
    } else {
      jsonBody = data;
    }
    return encoder.convert(jsonDecode(jsonEncode(jsonBody)));
  } else if (type?.contains('multipart/form-data') == true) {
    return const JsonEncoder.withIndent('   ').convert(formDataToJson(data));
  } else {
    return data.toString();
  }
}

String getQueryParams(Map<String, dynamic>? queryParams) {
  var result = '';

  if (queryParams != null && queryParams.isNotEmpty) {
    result += '===== Query Parameters =====';
    final params = <String>[];
    for (final entry in queryParams.entries) {
      params.add('${entry.key} : ${entry.value.toString()}');
    }
    result += '\n${params.join('\n')}';
  }
  return result;
}

Map<String, dynamic> formDataToJson(FormData formData) {
  final map = <String, dynamic>{};
  for (final entry in formData.fields) {
    map[entry.key] = entry.value;
  }
  for (final file in formData.files) {
    var responseString = '[application/octet-stream; ';
    if (file.value.filename != null) {
      responseString += 'filename=${file.value.filename}; ';
    }
    responseString += 'length=${file.value.length}]';
    map[file.key] = responseString;
  }
  return map;
}
