import 'dart:convert';
import 'package:corona_trac_helper/generated/i18n.dart';
import 'package:corona_trac_helper/src/data/model/parsed_response.dart';
import 'package:corona_trac_helper/src/infra/network/model/home/corona_response_data.dart';
import 'package:corona_trac_helper/src/ui/common/utils/text_utils.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_bloc.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/data/data.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/categorie_model.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/product_model.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/trending_productmodel.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/widgets/home_layout_widget.dart';
import 'package:corona_trac_helper/src/utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:corona_trac_helper/src/base/ui_event.dart';
import 'package:corona_trac_helper/src/infra/bloc/bloc_provider.dart';
import 'package:corona_trac_helper/src/infra/bloc/event_listener.dart';
import 'package:corona_trac_helper/src/ui/common/widgets/widget_mixin.dart';
import 'package:get_it/get_it.dart';

class CoronaHomeScreen extends StatelessWidget {
  static const ROUTE_NAME = "/corona_home_screen_route";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: CoronaHomeScreenBloc(),
      child: _CoronaHomeScreenInternal(),
    );
  }
}

class _CoronaHomeScreenInternal extends StatefulWidget {

  _CoronaHomeScreenInternal();

  @override
  _CoronaHomeScreenState createState() =>
      _CoronaHomeScreenState();
}

class _CoronaHomeScreenState extends State<_CoronaHomeScreenInternal> with CommonWidget{
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();
  List<TrendingProductModel> trendingProducts = new List();
  List<ProductModel> products = new List();
  List<CategorieModel> categories = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    trendingProducts = getTrendingProducts();
//    products = getProducts();
//    categories = getCategories();
  }

  Future<void> _onRefreshBalance() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      BlocProvider
          .of<CoronaHomeScreenBloc>(context)
          .getCoronaHomeData(showLoader: false);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return EventListener(
      BlocProvider
          .of<CoronaHomeScreenBloc>(context)
          .uiEventStream,
      handleEvent,
      child: Scaffold(
          key: _scafoldKey,
          appBar: AppBar(
            title: Center(child: Text(S.of(context).text_dashboard_title)),
//          leading: IconButton(
//            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
//            onPressed: () => Navigator.pop(context),
//          ),
          ),
          body: RefreshIndicator(
            onRefresh: _onRefreshBalance,
            child: SingleChildScrollView(
              child:  StreamBuilder<CoronaResponseData>(
                stream: BlocProvider
                    .of<CoronaHomeScreenBloc>(context)
                    .coronaHomeDataStream,
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Text(snapshot.error);
                  }

                  if(!snapshot.hasData && snapshot.data==null){
                    return SizedBox();
                  }
                  CoronaResponseData coronaResponseData = snapshot.data;
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("India Now", style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22
                            ),),
                            SizedBox(width: 12,),
                            Text(coronaResponseData.keyValues[0].lastupdatedtime)
                          ],
                        ),
                      ),

                      /// Search Bar
//                    Container(
//                      margin: EdgeInsets.symmetric(horizontal: 12),
//                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.circular(8),
//                        boxShadow: <BoxShadow>[
//                          BoxShadow(
//                            offset: Offset(5.0, 5.0),
//                            blurRadius: 5.0,
//                            color: Colors.black87.withOpacity(0.05),
//                          ),
//                        ],
//                      ),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//
//                          Padding(
//                            padding: const EdgeInsets.only(left: 9),
//                            child: Text("Search", style: TextStyle(
//                                color: Color(0xff9B9B9B),
//                                fontSize: 17
//                            ),),
//                          ),
//                          Spacer(),
//                          Icon(Icons.search),
//                        ],
//                      ),
//                    ),
                      Container(
                          height: 200,
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            childAspectRatio: 2,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Confirmed",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      " ${ coronaResponseData.statewise[0].confirmed}",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                color: ColorConstants.confirmed_color_dark,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Active",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      " ${ coronaResponseData.statewise[0].active}",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                color: ColorConstants.active_color_dark,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Recovered",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      " ${ coronaResponseData.statewise[0].recovered}",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                color: ColorConstants.recovered_color_dark,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Deaths",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      " ${ coronaResponseData.statewise[0].deaths}",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                color: ColorConstants.death_color_dark,
                              ),
                            ],
                          )
                      ),
                      /// Trending
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("Top Affected", style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22
                            ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      topAffetedStateList(coronaResponseData.statewise),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("States & District overview", style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22
                            ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      buildStateWiseDropDownList(coronaResponseData.statewise),
                      SizedBox(height: 50,),
//                    Container(
//                      height: 120,
//                      padding: EdgeInsets.only(left: 22),
//                      child: ListView.builder(
//                          itemCount: categories.length,
//                          shrinkWrap: true,
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (context, index){
//                            return CategorieTile(
//                              categorieName: categories[index].categorieName,
//                              imgAssetPath: categories[index].imgAssetPath,
//                              color1: categories[index].color1,
//                              color2: categories[index].color2,
//                            );
//                          }),
//                    )
                    ],
                  );
                }
              ),
            ),
          )
      ),
    );
  }

  Widget buildStateWiseDropDownList(List<Statewise> stateWiseData){
    List<Entry> prepareData=<Entry>[];
    ParsedResponse<Map<String, dynamic>> stateDistrictWiseData = BlocProvider.of<CoronaHomeScreenBloc>(context).stateDistrictWisedata;

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
                  CasesTypeData(confirmedCases:"bhh"),
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

    return Container(
      height: 300,
      child: ListView.builder(
          itemCount: stateWiseData.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            if(index==0){
              return SizedBox();
            }
            return EntryItem(prepareData[index]);
          }),
    );
  }

  Widget topAffetedStateList(List<Statewise> stateWiseData){
    List<Statewise> topAffectedStateList=[];

    //make mist of first 8 top affected states
    for(int i=1; i<=7; i++){
      topAffectedStateList.add(stateWiseData[i]);
    }
    return Container(
      padding: EdgeInsets.only(left: 22),
      width: double.infinity,
      height: 100,
      child: ListView.builder(
          itemCount: topAffectedStateList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return TopAffectedStateTile(
              stateName: topAffectedStateList[index].state,
              confirmedCases: topAffectedStateList[index].confirmed,
              activeCases: topAffectedStateList[index].active,
              deathCases: topAffectedStateList[index].deaths,
              recovCases: topAffectedStateList[index].recovered,
            );
          }),
    );
  }



  void handleEvent(UIEvent uiEvent) {
    if (uiEvent != null) {
      if (uiEvent is SnackBarEvent) {
        SnackBarEvent sbe = uiEvent;
        _scafoldKey.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          content: Text(sbe.message),
        ));
      }else if(uiEvent is LoadingScreenUiEvent) {
        LoadingScreenUiEvent loading = uiEvent;
        if(loading.isVisible) {
          showLoader(context);
        }else {
          hideLoader(context);
        }
      }
    }
  }
}


// ignore: must_be_immutable
class TopAffectedStateTile extends StatelessWidget {

  String stateName;
  String confirmedCases;
  String activeCases;
  String recovCases;
  String deathCases;
  String affectedToday;
  TopAffectedStateTile({this.stateName,this.confirmedCases, this.activeCases, this.deathCases, this.recovCases, this.affectedToday="120"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      margin: EdgeInsets.only(right: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 15.0,
            color: Colors.black87.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(stateName, style: TextStyle(
                        color: Colors.black87,
                        fontSize: 19),
                    ),
                    SizedBox(width: 10,),
//                    Icon(Icons.arrow_upward,color: ColorConstants.confirmed_color_dark,),
//                    Text("120", style: TextStyle(color: ColorConstants.confirmed_color_dark),)
                  ],
                ),

                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 12),alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4) ,
                          color: ColorConstants.confirmed_color_dark
                      ),
                      child: Text(
                        "${confirmedCases}", style: TextStyle(
                          fontSize: 11,
                          color: Colors.white
                      ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 12),alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4) ,
                          color: ColorConstants.active_color_dark
                      ),
                      child: Text(
                        "${activeCases}", style: TextStyle(
                          fontSize: 11,
                          color: Colors.white
                      ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 12),alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4) ,
                          color: ColorConstants.recovered_color_dark
                      ),
                      child: Text(
                        "${recovCases}", style: TextStyle(
                          fontSize: 11,
                          color: Colors.white
                      ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 12),alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4) ,
                          color: ColorConstants.death_color_dark
                      ),
                      child: Text(
                        "${deathCases}", style: TextStyle(
                          fontSize: 11,
                          color: Colors.white
                      ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CasesTypeData{
  String confirmedCases;
  String activeCases;
  String recoveredCases;
  String deathCases;
  CasesTypeData({this.confirmedCases, this.activeCases, this.recoveredCases, this.deathCases});
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.stateName, this.casesTypeData, [this.children = const <Entry>[]]);
  final String stateName;
  final List<Entry> children;
  final CasesTypeData casesTypeData;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry('Chapter A',
    CasesTypeData(activeCases: "122", confirmedCases: "12",deathCases: "12",recoveredCases: "12"),
    <Entry>[
      Entry('Section A0',
        CasesTypeData(activeCases: "12", confirmedCases: "12",deathCases: "12",recoveredCases: "12"),
        <Entry>[
          Entry(
              "sub list",
              CasesTypeData(activeCases: "12", confirmedCases: "12",deathCases: "12",recoveredCases: "12"),
              <Entry>[]
          ),
        ],
      ),
      Entry('Section A1', CasesTypeData(activeCases: "12", confirmedCases: "12",deathCases: "12",recoveredCases: "12")),
      Entry('Section A2', CasesTypeData(activeCases: "12", confirmedCases: "12",deathCases: "12",recoveredCases: "12"),),
    ],
  ),
  Entry('Chapter B',
    CasesTypeData(activeCases: "12", confirmedCases: "12",deathCases: "12",recoveredCases: "12"),
    <Entry>[
      Entry(
        'Section B0',
        CasesTypeData(activeCases: "12", confirmedCases: "12",deathCases: "12",recoveredCases: "12"),
        <Entry>[],
      ),
      Entry(
          'Section B1',
        CasesTypeData(activeCases: "12", confirmedCases: "12",deathCases: "12",recoveredCases: "12"),
      ),
    ],
  ),
];
// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  final Entry entry;
  const EntryItem(this.entry);
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(title: Text(root?.stateName));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(root?.stateName),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              !TextUtils.isEmpty(root?.casesTypeData?.confirmedCases)?
              Text(root?.casesTypeData?.confirmedCases, style: TextStyle(color: ColorConstants.confirmed_color_dark),):SizedBox(),

              !TextUtils.isEmpty(root?.casesTypeData?.activeCases)?
              Text(root?.casesTypeData?.activeCases, style: TextStyle(color: ColorConstants.active_color_dark),):SizedBox(),

              !TextUtils.isEmpty(root?.casesTypeData?.recoveredCases)?
              Text(root?.casesTypeData?.recoveredCases, style: TextStyle(color: ColorConstants.recovered_color_dark),):SizedBox(),

              !TextUtils.isEmpty(root?.casesTypeData?.deathCases)?
              Text(root?.casesTypeData?.deathCases, style: TextStyle(color: ColorConstants.death_color_dark),):SizedBox()
            ],
          ),
        ],
      ),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

class StateWiseResponse {
  Map<String, dynamic> districtData;

  StateWiseResponse({this.districtData});

  StateWiseResponse.fromJson(Map<String, dynamic> json) {
    if(json['districtData']!=null){
      districtData = json['districtData'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class StateWiseConfirmed {
  int confirmed;

  StateWiseConfirmed({this.confirmed});

  StateWiseConfirmed.fromJson(Map<String, dynamic> json) {
    if(json['confirmed']!=null){
      confirmed = json['confirmed'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

