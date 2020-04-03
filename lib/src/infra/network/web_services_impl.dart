import 'package:dio/dio.dart';
import 'package:corona_trac_helper/src/data/web_services.dart';
import 'package:corona_trac_helper/src/infra/network/m_dio.dart';

class WebServicesImpl extends WebServices {
  String _baseUrl;
  Dio _mDio;

  WebServicesImpl(this._baseUrl) {
    _mDio = new MDio().getDio(_baseUrl);
  }

  @override
  Future<Response> doGetApiCall(String endPoint,
      {Map<String, dynamic> qParams}) {
    return _mDio.get(endPoint, queryParameters: qParams);
  }

  @override
  Future<Response> doPostApiCall(String endPoint,
      {Map<String, dynamic> body}) {
    return _mDio.post(endPoint, data: body);
  }
}
