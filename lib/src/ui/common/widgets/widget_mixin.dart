import 'dart:async';
import 'package:flutter/material.dart';
import 'package:corona_trac_helper/src/utility/asset_constants.dart';
import 'package:corona_trac_helper/src/utility/color_constants.dart';


class CommonWidget {
  bool _isLoaderVisible = false;

  void showLoader(BuildContext context) {
    if (_isLoaderVisible) return;
    _isLoaderVisible = true;
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black45,
            child: Center(
              child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator()),
            ),
          );
        });
  }

  void genericSuccessDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 100,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.done, size: 30, color: Colors.green,),
                    Center(child: Text(message)),
                  ],
                )
            ),
          );
        });
  }

  void hideLoader(BuildContext context) {
    if(_isLoaderVisible) Navigator.pop(context);
    _isLoaderVisible = false;
  }

  Widget lineContainer({width = double.infinity}) {
    return Container(
      width: width,
      height: 1.5,
      color: ColorConstants.input_border_color,
    );
  }

  Widget customLineContainer({width = 50.0, height: 1.5, color: Color}) {
    return Container(
      width: double.maxFinite,
      height: height,
      color: color,
    );
  }

  Widget bgContainer() {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConstants.bg_pitch_black),
            fit: BoxFit.fill,
          ),
        ));
  }

  Widget showProgressBar(Stream<bool> progressBarStream) {
    return StreamBuilder<bool>(
        stream: progressBarStream,
        builder: (context, snapshot) {
          return Visibility(
            visible: (snapshot.hasData && snapshot.data),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black45,
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        });
  }

  showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


  Widget getDefaultSnackbar(String message) {
    return SnackBar(
      content: Text(message),
    );
  }


  Widget genericInputField(TextEditingController controller,
      { Color textColor = ColorConstants.input_text_color,
        Color inputBackgroundColor =  ColorConstants.input_bg_color,
        String hitText,
        FocusNode focusNode,
        bool enabled = true,
        bool typePassword = false,
        bool typePhoneNumber = false}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.input_border_color, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: inputBackgroundColor),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0, bottom: 5.0),
        child: TextField(
          obscureText: typePassword,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: typePhoneNumber ?TextInputType.phone : null,
          style: TextStyle(color: textColor),
          decoration: InputDecoration.collapsed(
            hintText: hitText,
            hintStyle: TextStyle(color: textColor, fontSize: 14)
          ),
          controller: controller,
        ),
      ),
    );
  }


  Widget inputWidgetWithHeader(String title, TextEditingController controller,
      {Color titleColor = Colors.black,
        Color textColor = Colors.black,
        FocusNode focusNode,
        bool enabled = true,
        bool typePhoneNo = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 3, left: 3),
            child: Text(
              title,
              style: TextStyle(color: Colors.red),
            )),
        Container(
          child: genericInputField(controller,enabled: enabled,
              textColor: textColor, typePhoneNumber: typePhoneNo, focusNode: focusNode),
        ),
      ],
    );
  }

  Widget genericAssetIconContainer(String imagePath){
    return  Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(imagePath))),
    );
  }

  Widget buildProgressIndicator() {
    return Container(
      height: 50,
      width: 50,
      child: Center(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Opacity(
            opacity: 1.0,
            child: new CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
