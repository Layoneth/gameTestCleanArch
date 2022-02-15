import 'dart:io';

import 'package:dio/dio.dart';

class Constants {

  static const baseUrl = 'https://api.igdb.com/v4';
  static const token = '6aec3k9s17m2ln811ejlxujuunk42u';
  static const clientId = 'ikefu3gjaojsnnt21ik7orxyofnztq';
  static final dioOptions = Options(
    headers: {
      'Content-Type': 'application/json',
      'Client-ID': clientId,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }
  );

}