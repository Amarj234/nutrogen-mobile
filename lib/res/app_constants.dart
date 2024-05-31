import 'package:flutter/foundation.dart';

class AppConstants {
  AppConstants._();

  static const bool isDebugMode = kDebugMode;

  static const String appName = 'Nutrogen';
  static const String baseUrl = 'https://api.nutrogen.io/api/';
  static const String baseImageUrl = 'https://api.nutrogen.io/upload/';

  /* -------------------------------------------------------------------------- */
  /*                                    KEYS                                    */
  /* -------------------------------------------------------------------------- */

  static const requestCallTimeKey = 'request_call_time';
  static const authenticationKey = 'authentication';
  static const networkStatusKey = 'network_status';
  static const userKey = 'user_key';
  static const tokenKey = 'token_key';
}
