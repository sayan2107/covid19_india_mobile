class CoronaResponseData {
  List<CasesTimeSeries> casesTimeSeries;
  List<KeyValues> keyValues;
  List<Statewise> statewise;
  List<Tested> tested;

  CoronaResponseData(
      {this.casesTimeSeries, this.keyValues, this.statewise, this.tested});

  CoronaResponseData.fromJson(Map<String, dynamic> json) {
    if (json['cases_time_series'] != null) {
      casesTimeSeries = new List<CasesTimeSeries>();
      json['cases_time_series'].forEach((v) {
        casesTimeSeries.add(new CasesTimeSeries.fromJson(v));
      });
    }
    if (json['key_values'] != null) {
      keyValues = new List<KeyValues>();
      json['key_values'].forEach((v) {
        keyValues.add(new KeyValues.fromJson(v));
      });
    }
    if (json['statewise'] != null) {
      statewise = new List<Statewise>();
      json['statewise'].forEach((v) {
        statewise.add(new Statewise.fromJson(v));
      });
    }
    if (json['tested'] != null) {
      tested = new List<Tested>();
      json['tested'].forEach((v) {
        tested.add(new Tested.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.casesTimeSeries != null) {
      data['cases_time_series'] =
          this.casesTimeSeries.map((v) => v.toJson()).toList();
    }
    if (this.keyValues != null) {
      data['key_values'] = this.keyValues.map((v) => v.toJson()).toList();
    }
    if (this.statewise != null) {
      data['statewise'] = this.statewise.map((v) => v.toJson()).toList();
    }
    if (this.tested != null) {
      data['tested'] = this.tested.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CasesTimeSeries {
  String dailyconfirmed;
  String dailydeceased;
  String dailyrecovered;
  String date;
  String totalconfirmed;
  String totaldeceased;
  String totalrecovered;

  CasesTimeSeries(
      {this.dailyconfirmed,
        this.dailydeceased,
        this.dailyrecovered,
        this.date,
        this.totalconfirmed,
        this.totaldeceased,
        this.totalrecovered});

  CasesTimeSeries.fromJson(Map<String, dynamic> json) {
    dailyconfirmed = json['dailyconfirmed'];
    dailydeceased = json['dailydeceased'];
    dailyrecovered = json['dailyrecovered'];
    date = json['date'];
    totalconfirmed = json['totalconfirmed'];
    totaldeceased = json['totaldeceased'];
    totalrecovered = json['totalrecovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dailyconfirmed'] = this.dailyconfirmed;
    data['dailydeceased'] = this.dailydeceased;
    data['dailyrecovered'] = this.dailyrecovered;
    data['date'] = this.date;
    data['totalconfirmed'] = this.totalconfirmed;
    data['totaldeceased'] = this.totaldeceased;
    data['totalrecovered'] = this.totalrecovered;
    return data;
  }
}

class KeyValues {
  String confirmeddelta;
  String counterforautotimeupdate;
  String deceaseddelta;
  String lastupdatedtime;
  String recovereddelta;
  String statesdelta;

  KeyValues(
      {this.confirmeddelta,
        this.counterforautotimeupdate,
        this.deceaseddelta,
        this.lastupdatedtime,
        this.recovereddelta,
        this.statesdelta});

  KeyValues.fromJson(Map<String, dynamic> json) {
    confirmeddelta = json['confirmeddelta'];
    counterforautotimeupdate = json['counterforautotimeupdate'];
    deceaseddelta = json['deceaseddelta'];
    lastupdatedtime = json['lastupdatedtime'];
    recovereddelta = json['recovereddelta'];
    statesdelta = json['statesdelta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmeddelta'] = this.confirmeddelta;
    data['counterforautotimeupdate'] = this.counterforautotimeupdate;
    data['deceaseddelta'] = this.deceaseddelta;
    data['lastupdatedtime'] = this.lastupdatedtime;
    data['recovereddelta'] = this.recovereddelta;
    data['statesdelta'] = this.statesdelta;
    return data;
  }
}

class Statewise {
  String active;
  String confirmed;
  String deaths;
  Delta delta;
  String deltaconfirmed;
  String deltadeaths;
  String deltarecovered;
  String lastupdatedtime;
  String recovered;
  String state;
  String statecode;

  Statewise(
      {this.active,
        this.confirmed,
        this.deaths,
        this.delta,
        this.deltaconfirmed,
        this.deltadeaths,
        this.deltarecovered,
        this.lastupdatedtime,
        this.recovered,
        this.state,
        this.statecode});

  Statewise.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    delta = json['delta'] != null ? new Delta.fromJson(json['delta']) : null;
    deltaconfirmed = json['deltaconfirmed'];
    deltadeaths = json['deltadeaths'];
    deltarecovered = json['deltarecovered'];
    lastupdatedtime = json['lastupdatedtime'];
    recovered = json['recovered'];
    state = json['state'];
    statecode = json['statecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    if (this.delta != null) {
      data['delta'] = this.delta.toJson();
    }
    data['deltaconfirmed'] = this.deltaconfirmed;
    data['deltadeaths'] = this.deltadeaths;
    data['deltarecovered'] = this.deltarecovered;
    data['lastupdatedtime'] = this.lastupdatedtime;
    data['recovered'] = this.recovered;
    data['state'] = this.state;
    data['statecode'] = this.statecode;
    return data;
  }
}

class Delta {
  int active;
  int confirmed;
  int deaths;
  int recovered;

  Delta({this.active, this.confirmed, this.deaths, this.recovered});

  Delta.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}

class Tested {
  String source;
  String testsconductedbyprivatelabs;
  String totalindividualstested;
  String totalpositivecases;
  String totalsamplestested;
  String updatetimestamp;

  Tested(
      {this.source,
        this.testsconductedbyprivatelabs,
        this.totalindividualstested,
        this.totalpositivecases,
        this.totalsamplestested,
        this.updatetimestamp});

  Tested.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    testsconductedbyprivatelabs = json['testsconductedbyprivatelabs'];
    totalindividualstested = json['totalindividualstested'];
    totalpositivecases = json['totalpositivecases'];
    totalsamplestested = json['totalsamplestested'];
    updatetimestamp = json['updatetimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['testsconductedbyprivatelabs'] = this.testsconductedbyprivatelabs;
    data['totalindividualstested'] = this.totalindividualstested;
    data['totalpositivecases'] = this.totalpositivecases;
    data['totalsamplestested'] = this.totalsamplestested;
    data['updatetimestamp'] = this.updatetimestamp;
    return data;
  }
}
