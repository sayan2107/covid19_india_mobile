import 'package:dio/dio.dart';
import 'package:corona_trac_helper/src/infra/network/model/api_error_model.dart';
import 'package:corona_trac_helper/src/utility/log.dart';

abstract class BaseRepository {
  static const int HTTP_OK = 200;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NO_INTERNET_CONNECTION = -101;
  static const int UNKNOWN = 0;

  ApiErrorModel handleHttpErrorResponse(Response response) {

    if(response != null) {
      switch(response.statusCode) {
        case BAD_REQUEST:
          return ApiErrorModel.fromJson(response.data);

      }
    }
    return ApiErrorModel(UNKNOWN, "Unknown error");
  }

  ApiErrorModel handleDioError(DioError dioError) {
    Log.d("Dio ERROR=> ", dioError.toString());
    String message = dioError.message;
    if(dioError.response != null) {
      return ApiErrorModel(dioError.response.statusCode, message, dioError);
    } else {
      return ApiErrorModel(UNKNOWN, message, dioError);
    }
  }

}