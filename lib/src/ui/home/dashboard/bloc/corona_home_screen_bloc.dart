import 'package:corona_trac_helper/src/data/model/parsed_response.dart';
import 'package:corona_trac_helper/src/data/model/home/corona_response_data.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_events.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_repository.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/corona_home_helper_models.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/screens/corona_home_screen.dart';
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

  BehaviorSubject<List<Entry>> _stateDistrictWiseDataStreamController = BehaviorSubject();
  Stream<List<Entry>> get stateDistrictWiseDataStream => _stateDistrictWiseDataStreamController.stream;


  void getCoronaHomeData({bool showLoader=true}) async {
      _uiEventStreamController.add(LoadingScreenUiEvent(showLoader));
      ParsedResponse<CoronaResponseData> coronaHomeDataResponse = await _coronaHomeDataRepository.fetchCoronaHomeData();
      _prepareStateDistrictData(coronaHomeDataResponse.data.statewise);
      _uiEventStreamController.add(LoadingScreenUiEvent(false));
      if(coronaHomeDataResponse.hasData) {
        _coronaHomeDataStreamController.add(coronaHomeDataResponse.data);
      } else {
        _uiEventStreamController.add(SnackBarEvent(coronaHomeDataResponse.error.message));
      }
    }

   void _prepareStateDistrictData(List<Statewise> stateWiseData) async{
     ParsedResponse<Map<String, dynamic>> stateDistrictWiseData = await _coronaHomeDataRepository.fetchStateDistrictWiseData();
     List<Entry> prepareData=<Entry>[];
     if(stateDistrictWiseData.hasData){
       for(int i=0; i<stateWiseData.length; i++){
         List<Entry> districtData=[];
         Map<String, dynamic> stateData = stateDistrictWiseData?.data[stateWiseData[i]?.state];
         StateWiseResponse obj=StateWiseResponse();
         if(stateData!=null){
           obj = StateWiseResponse.fromJson(stateData);
         }

         obj?.districtData?.forEach((k, v)  {
           StateWiseConfirmed confirmedCountState = StateWiseConfirmed();
           if(v!=null){
             confirmedCountState = StateWiseConfirmed.fromJson(v);
           }
           districtData.add(
               Entry(
                 k,
                 CasesTypeData(confirmedCases: confirmedCountState?.confirmed.toString()),
                 <Entry>[
                   Entry(
                       "End of list",
                       CasesTypeData(confirmedCases:"NA"),
                       <Entry>[]
                   ),
                 ],
               )
           );
         });

         Entry singleStateEntryData = Entry(
           stateWiseData[i].state,
           CasesTypeData(
               recoveredCases: stateWiseData[i].recovered,
               deathCases: stateWiseData[i].deaths,
               confirmedCases: stateWiseData[i].confirmed,
               activeCases: stateWiseData[i].active
           ),
           districtData,
         );
         prepareData.add(singleStateEntryData);
       }
     }

     if(stateDistrictWiseData.hasError){
       //TODO error handling
     }

     _stateDistrictWiseDataStreamController.sink.add(prepareData);
   }
   


  @override
  void onDispose() {
    _uiEventStreamController.close();
    _stateDistrictWiseDataStreamController.close();
    _coronaHomeDataStreamController.close();
  }

}