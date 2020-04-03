import 'package:corona_trac_helper/generated/i18n.dart';
import 'package:corona_trac_helper/src/infra/network/model/home/corona_response_data.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_bloc.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/data/data.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/trending_productmodel.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/widgets/home_layout_widget.dart';
import 'package:corona_trac_helper/src/utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:corona_trac_helper/src/base/ui_event.dart';
import 'package:corona_trac_helper/src/infra/bloc/bloc_provider.dart';
import 'package:corona_trac_helper/src/infra/bloc/event_listener.dart';
import 'package:corona_trac_helper/src/ui/common/widgets/widget_mixin.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingProducts = getTrendingProducts();
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
          body: SingleChildScrollView(
            child:  StreamBuilder<CoronaResponseData>(
              stream: BlocProvider
                  .of<CoronaHomeScreenBloc>(context)
                  .coronaHomeDataStream,
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text(snapshot.error);
                }

                if(snapshot.data==null){
                  return CircularProgressIndicator();
                }
                CoronaResponseData coronaResponseData = snapshot.data;
                return Column(
                  children: <Widget>[
                    SizedBox(height: 50,),

                    /// Search Bar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 5.0,
                            color: Colors.black87.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Text("Search", style: TextStyle(
                                color: Color(0xff9B9B9B),
                                fontSize: 17
                            ),),
                          ),
                          Spacer(),
                          Icon(Icons.search),
                        ],
                      ),
                    ),
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
                              child:  Center(
                                  child: Text(
                                    "Confirmed: ${  coronaResponseData.statewise[0].confirmed}",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  )
                              ),
                              color: ColorConstants.confirmed_color_dark,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child:  Center(
                                  child: Text(
                                    "Active: ${  coronaResponseData.statewise[0].active}",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  )
                              ),
                              color: ColorConstants.active_color_dark,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child:  Center(
                                  child: Text(
                                    "Recovered: ${  coronaResponseData.statewise[0].recovered}",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  )
                              ),
                              color: ColorConstants.recovered_color_dark,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                  child: Text("Deaths: ${  coronaResponseData.statewise[0].deaths}",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  )
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
                          Text("Top Affected Today", style: TextStyle(
                              color: Colors.black87,
                              fontSize: 22
                          ),),
                          SizedBox(width: 12,),
                          Text("4 March")
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    topAffetedStateList(coronaResponseData.statewise),
                  ],
                );
              }
            ),
          )
      ),
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
      height: 150,
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
      width: MediaQuery.of(context).size.width - 70,
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
//          Container(
//            child: Stack(
//              children: <Widget>[
//                Image.asset("assets/image.png",height: 150,fit: BoxFit.cover,) ,
//                Container(
//                  height: 25,
//                  width: 50,
//                  margin: EdgeInsets.only(left: 5,top: 5),
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(6) ,
//                      gradient: LinearGradient(
//                          colors: [const Color(0xff8EA2FF).withOpacity(0.5), const Color(0xff557AC7).withOpacity(0.5)]
//                      )
//                  ),
//                  child: Text("\$$priceInDollars",style: TextStyle(
//                      color: Colors.white
//                  ),
//                  ),
//                ),
//              ],
//            ),
//          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(stateName, style: TextStyle(
                    color: Colors.black87,
                    fontSize: 19
                ),),
                Row(
                  children: <Widget>[
                    Icon(Icons.arrow_upward,color: ColorConstants.confirmed_color_dark,),
                    Text("${affectedToday}", style: TextStyle(color: ColorConstants.confirmed_color_dark),)
                  ],
                ),
                SizedBox(height: 8,),
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
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

