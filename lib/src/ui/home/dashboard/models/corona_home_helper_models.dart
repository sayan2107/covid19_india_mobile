import 'package:flutter/material.dart';

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

class ButtonStyleConfig{
  String iconPath;
  String title;
  Color btnColor;
  Color btnTextColor;
  Function onClickFunction;

  ButtonStyleConfig({this.iconPath, this.title, this.btnColor, this.onClickFunction, this.btnTextColor});
}