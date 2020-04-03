import 'package:corona_trac_helper/src/base/ui_event.dart';
import 'package:corona_trac_helper/src/data/model/home/music_data/music_model.dart';
class NavigateToDetails extends UIEvent {
  Results results;
  NavigateToDetails(this.results) : super(null);
}