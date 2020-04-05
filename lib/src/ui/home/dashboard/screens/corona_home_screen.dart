import 'package:corona_trac_helper/generated/i18n.dart';
import 'package:corona_trac_helper/src/infra/network/model/home/corona_response_data.dart';
import 'package:corona_trac_helper/src/ui/common/services/common_services.dart';
import 'package:corona_trac_helper/src/ui/common/utils/text_utils.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_bloc.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/corona_home_helper_models.dart';
import 'package:corona_trac_helper/src/utility/asset_constants.dart';
import 'package:corona_trac_helper/src/utility/color_constants.dart';
import 'package:corona_trac_helper/src/utility/url_constants.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _onRefreshBalance() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      BlocProvider
          .of<CoronaHomeScreenBloc>(context)
          .getCoronaHomeData(showLoader: false);
    });
    return null;
  }

  Widget socialMediaBtn(ButtonStyleConfig config){
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: config.btnColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            genericAssetIconContainer(config.iconPath),
            SizedBox(width: 5,),
            Text(config.title.toUpperCase(),style: TextStyle(color: config.btnTextColor),),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: config.onClickFunction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EventListener(
      BlocProvider
          .of<CoronaHomeScreenBloc>(context)
          .uiEventStream,
      handleEvent,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Want to join with me?\nOpen Source On:",style: TextStyle(color: Colors.white),),
                    socialMediaBtn(
                        ButtonStyleConfig(
                          title: "github",
                          iconPath: AssetConstants.ic_github_logo,
                          btnColor: Colors.white,
                          btnTextColor: Colors.black,
                          onClickFunction: (){CommonServices.launchURL(UrlConstants.my_github_profile_link);}
                        )
                    ),
//                    socialMediaBtn(
//                        ButtonStyleConfig(
//                            title: "LinkedIn",
//                            iconPath: AssetConstants.ic_nothing_found,
//                            btnColor: Colors.black12,
//                            btnTextColor: Colors.white,
//                            onClickFunction: (){CommonServices.launchURL(UrlConstants.my_linkedin_profile_link);}
//                        )
//                    ),
                  ],
                )),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),

              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Thanks to:'),
                    socialMediaBtn(
                        ButtonStyleConfig(
                            title: "covid19india.org",
                            iconPath: AssetConstants.ic_nothing_found,
                            btnColor: Colors.black12,
                            btnTextColor: Colors.white,
                            onClickFunction: (){CommonServices.launchURL(UrlConstants.covid19_org_url);}
                        )
                    ),
                    socialMediaBtn(
                        ButtonStyleConfig(
                            title: "Database",
                            iconPath: AssetConstants.ic_nothing_found,
                            btnColor: Colors.greenAccent,
                            btnTextColor: Colors.white,
                            onClickFunction: (){CommonServices.launchURL(UrlConstants.patient_db_url);}
                        )
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              ListTile(
                title: Text('About me: \nName: Sayon Mazumder\nAge: 25\nWant to know more about me?'),
              ),

              ListTile(
                title: socialMediaBtn(
                    ButtonStyleConfig(
                        title: "LinkedIn",
                        iconPath: AssetConstants.ic_linkedin_logo,
                        btnColor: Colors.lightBlue,
                        btnTextColor: Colors.white,
                        onClickFunction: (){CommonServices.launchURL(UrlConstants.my_linkedin_profile_link);}
                    )
                ),
              ),

              SizedBox(height: 10,),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Feel free to get in touch with me:"),
                    socialMediaBtn(
                        ButtonStyleConfig(
                            title: "Email",
                            iconPath: AssetConstants.ic_email_logo,
                            btnColor: Colors.redAccent,
                            btnTextColor: Colors.white,
                            onClickFunction: (){CommonServices.launchURL("mailto:sayan.mywork@gmail.com?subject=COVID19 APP FEEDBACK");}
                        )
                    ),
                  ],
                ),
              ),

              ListTile(
                title: Text("Let's beat Corona Together...",style: TextStyle(fontSize: 16),),
              ),


            ],
          ),
        ),
          key: _scafoldKey,
          appBar: AppBar(
            centerTitle:true ,
            title: Text(S.of(context).text_dashboard_title),
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
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text("Last update on:\n${coronaResponseData?.statewise[0]?.lastupdatedtime}"),
                                ],
                              ),
                            )
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
                            Text("Top Affected States", style: TextStyle(
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
                            Text("States & Districts overview", style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22
                            ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      buildStateWiseDropDownList(),
//                      SizedBox(height: 50,),
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


  Widget buildStateWiseDropDownList(){
    return StreamBuilder<List<Entry>>(
      stream: BlocProvider.of<CoronaHomeScreenBloc>(context).stateDistrictWiseDataStream,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text("something went wrong");
        }
        if(!snapshot.hasData){
          return SizedBox();
        }
        List<Entry> stateDistrictData = snapshot.data;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Container(
            height: 300,
            child: ListView.builder(
                itemCount: stateDistrictData.length,
                shrinkWrap: false,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  if(index==0){
                    return SizedBox();
                  }
                  return EntryItem(stateDistrictData[index]);
                }),
          ),
        );
      }
    );
  }

  Widget topAffetedStateList(List<Statewise> stateWiseData){
    List<Statewise> topAffectedStateList=[];
    //make mist of first 8 top affected states
    for(int i=1; i<=7; i++){
      topAffectedStateList.add(stateWiseData[i]);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
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

