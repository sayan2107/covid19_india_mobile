import 'package:corona_trac_helper/src/ui/home/dashboard/screens/corona_home_screen.dart';
import 'package:corona_trac_helper/src/utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:corona_trac_helper/src/routes.dart';
import 'package:corona_trac_helper/generated/i18n.dart';

class CoronaTrackerApp extends StatefulWidget {
  static const locale = [Locale("en", "")];

  static void setLocale(BuildContext context, Locale newLocale) async {
    _CoronaTrackerAppState state =
        context.ancestorStateOfType(TypeMatcher<_CoronaTrackerAppState>());

    state.setState(() {
      state.locale = newLocale;
    });
  }

  @override
  _CoronaTrackerAppState createState() => _CoronaTrackerAppState();
}

class _CoronaTrackerAppState extends State<CoronaTrackerApp> {
  var locale = CoronaTrackerApp.locale[0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.blue,
//          primaryColor: Colors.black,
//          primaryColorDark: ColorConstants.input_bg_color_dark,
//          accentColor: Colors.grey,
          fontFamily: 'Poppins'),
      localizationsDelegates: [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: S.delegate.resolution(fallback: locale),
      home: CoronaHomeScreen(),
      onGenerateRoute: (RouteSettings settings) {
        return Routes.onGenerateRoute(settings);
      },
    );
  }
}
