import 'package:dio/dio.dart';
import 'package:corona_trac_helper/src/utility/log.dart';

class MDio {
  Dio dio;

  Dio getDio(String baseUrl) {
    if(dio == null) {
      dio = Dio(
        new BaseOptions(
          baseUrl: baseUrl
        )
      );
      dio.interceptors.add(MDioInterceptor());
    }
    return dio;
  }
}

class MDioInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {

    options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;

    options.headers[Headers.acceptHeader] = Headers.jsonContentType;

    Log.d("Request Url => ", options.path);
    Log.d("\nHeaders => ", options.headers.toString());

    if(options.data != null && options.queryParameters.isNotEmpty) {
      Log.d("\nHttp Request=>\n", options.data.toString());
    }

    if(options.queryParameters != null && options.queryParameters.isNotEmpty) {
      Log.d("\nQuery Params =>\n", options.queryParameters.toString());
    }

    return options;
  }

  @override
  Future onResponse(Response response) async {
    Log.d("Response Url=> ", response.request.path);
    Log.d("Response=> ", response.data.toString());

    return response;
  }
}