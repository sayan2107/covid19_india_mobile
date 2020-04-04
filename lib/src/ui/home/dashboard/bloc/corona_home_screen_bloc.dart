import 'package:corona_trac_helper/src/data/model/home/music_data/music_model.dart';
import 'package:corona_trac_helper/src/data/model/parsed_response.dart';
import 'package:corona_trac_helper/src/infra/network/model/home/corona_response_data.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_events.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:corona_trac_helper/src/base/ui_event.dart';
import 'package:corona_trac_helper/src/data/web_services.dart';
import 'package:corona_trac_helper/src/infra/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class CoronaHomeScreenBloc extends BaseBloc {

  CoronaHomeScreenRepository _coronaHomeDataRepository;

  CoronaHomeScreenBloc() {
    _coronaHomeDataRepository = CoronaHomeScreenRepository(GetIt.I<WebServices>());
    getCoronaHomeData();
  }

  BehaviorSubject<UIEvent> _uiEventStreamController = BehaviorSubject();
  Stream<UIEvent> get uiEventStream => _uiEventStreamController.stream;

  BehaviorSubject<CoronaResponseData> _coronaHomeDataStreamController = BehaviorSubject();
  Stream<CoronaResponseData> get coronaHomeDataStream => _coronaHomeDataStreamController.stream;

  BehaviorSubject<Map<String, dynamic>> _stateDistrictWiseDataStreamController = BehaviorSubject();
  Stream<Map<String, dynamic>> get stateDistrictWiseDataStream => _stateDistrictWiseDataStreamController.stream;

  ParsedResponse<Map<String, dynamic>> stateDistrictWisedata;


  void getCoronaHomeData({bool showLoader=true}) async {
      _uiEventStreamController.add(LoadingScreenUiEvent(showLoader));
      getStateDistrictWiseData();
      ParsedResponse<CoronaResponseData> coronaHomeDataResponse = await _coronaHomeDataRepository.fetchCoronaHomeData();
      _uiEventStreamController.add(LoadingScreenUiEvent(false));
      if(coronaHomeDataResponse.hasData) {
        _coronaHomeDataStreamController.add(coronaHomeDataResponse.data);
      } else {
        _uiEventStreamController.add(SnackBarEvent(coronaHomeDataResponse.error.message));
      }
    }

  void getStateDistrictWiseData() async {
    //_uiEventStreamController.add(LoadingScreenUiEvent(true));
    ParsedResponse<Map<String, dynamic>> stateDistrictWiseDataResponse = await _coronaHomeDataRepository.fetchStateDistrictWiseData();
    stateDistrictWisedata = stateDistrictWiseDataResponse;
    //_uiEventStreamController.add(LoadingScreenUiEvent(false));
    if(stateDistrictWiseDataResponse.hasData) {
      _stateDistrictWiseDataStreamController.add(stateDistrictWiseDataResponse.data);
    } else {
     // _uiEventStreamController.add(SnackBarEvent(stateDistrictWiseDataResponse.error.message));
    }
  }

  void redirectToMusicDetails(Results result) {
    _uiEventStreamController.add(NavigateToDetails(result));
  }



  @override
  void onDispose() {
    _uiEventStreamController.close();
    _stateDistrictWiseDataStreamController.close();
    _coronaHomeDataStreamController.close();
  }

}