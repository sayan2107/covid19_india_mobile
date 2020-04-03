import 'package:dio/dio.dart';

abstract class WebServices {
  Future<Response> doPostApiCall(String endPoint, {Map<String, dynamic> body});

  Future<Response> doGetApiCall(String endPoint, {Map<String, dynamic> qParams});
}
