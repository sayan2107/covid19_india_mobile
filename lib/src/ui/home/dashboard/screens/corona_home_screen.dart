import 'package:corona_trac_helper/generated/i18n.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/bloc/corona_home_screen_bloc.dart';
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
  Widget build(BuildContext context) {
    return EventListener(
      BlocProvider
          .of<CoronaHomeScreenBloc>(context)
          .uiEventStream,
      handleEvent,
      child: Scaffold(
          key: _scafoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(child: Text(S.of(context).text_music_list)),
//          leading: IconButton(
//            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
//            onPressed: () => Navigator.pop(context),
//          ),
          ),
          body: Text("hii from home")
      ),
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
