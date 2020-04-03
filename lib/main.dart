import 'package:corona_trac_helper/src/corona_tracker_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:corona_trac_helper/src/data/shared_pref.dart';
import 'package:corona_trac_helper/src/data/web_services.dart';
import 'package:corona_trac_helper/src/infra/network/web_services_impl.dart';
import 'package:corona_trac_helper/src/infra/sharedpreference_helper.dart';
import 'package:corona_trac_helper/src/utility/url_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpDependencyInjection();

  runApp(CoronaTrackerApp());
}

void setUpDependencyInjection() {
  GetIt.instance.registerLazySingleton<SharedPrefData>(() => SharedPrefsImpl());
  GetIt.instance.registerLazySingleton<WebServices>(() => WebServicesImpl(UrlConstants.BASE_URL));
}
