import 'package:dio/dio.dart';
import 'package:corona_trac_helper/src/base/base_repository.dart';
import 'package:corona_trac_helper/src/data/model/home/music_data/music_model.dart';
import 'package:corona_trac_helper/src/data/model/parsed_response.dart';
import 'package:corona_trac_helper/src/data/web_services.dart';
import 'package:corona_trac_helper/src/utility/url_constants.dart';

class CoronaHomeScreenRepository extends BaseRepository {
  WebServices _webServices;

  CoronaHomeScreenRepository(this._webServices);

  Future<ParsedResponse<MusicDataResponse>> fetchMusicData() async {
    try {
      Response response = await _webServices.doGetApiCall(UrlConstants.music_data);
      if(response != null && response.statusCode == BaseRepository.HTTP_OK) {
        return ParsedResponse.addData(MusicDataResponse.fromJson(response.data));
      } else {
        return Future.value(ParsedResponse.addError(handleHttpErrorResponse(response)));
      }
    } on DioError catch(e) {
      return Future.value(ParsedResponse.addError(handleDioError(e)));
    }
  }

}