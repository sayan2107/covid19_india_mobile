import 'package:corona_trac_helper/src/data/model/home/corona_response_data.dart';
import 'package:dio/dio.dart';
import 'package:corona_trac_helper/src/base/base_repository.dart';
import 'package:corona_trac_helper/src/data/model/parsed_response.dart';
import 'package:corona_trac_helper/src/data/web_services.dart';
import 'package:corona_trac_helper/src/utility/url_constants.dart';

class CoronaHomeScreenRepository extends BaseRepository {
  WebServices _webServices;

  CoronaHomeScreenRepository(this._webServices);

  Future<ParsedResponse<CoronaResponseData>> fetchCoronaHomeData() async {
    try {
      Response response = await _webServices.doGetApiCall(UrlConstants.corona_home_data);
      if(response != null && response.statusCode == BaseRepository.HTTP_OK) {
        return ParsedResponse.addData(CoronaResponseData.fromJson(response.data));
      } else {
        return Future.value(ParsedResponse.addError(handleHttpErrorResponse(response)));
      }
    } on DioError catch(e) {
      return Future.value(ParsedResponse.addError(handleDioError(e)));
    }
  }

  Future<ParsedResponse<Map<String, dynamic>>> fetchStateDistrictWiseData() async {
    try {
      Response response = await _webServices.doGetApiCall(UrlConstants.corona_state_district_wise_data);
      if(response != null && response.statusCode == BaseRepository.HTTP_OK) {
        return ParsedResponse.addData(response.data);
      } else {
        return Future.value(ParsedResponse.addError(handleHttpErrorResponse(response)));
      }
    } on DioError catch(e) {
      return Future.value(ParsedResponse.addError(handleDioError(e)));
    }
  }

}