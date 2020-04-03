abstract class UIEvent {
  dynamic _payLoad;
  dynamic get payload => _payLoad;

  UIEvent(this._payLoad);
}


/// To Show Snackbar to the user
class SnackBarEvent extends UIEvent {
  final String message;
  SnackBarEvent(this.message) : super(message);
}


/// To Show dialog on Screen
class DialogEvent extends UIEvent {
  static const DIALOG_TYPE_NETWORK_ERROR = 0;
  static const DIALOG_TYPE_OH_SNAP = 1;
  static const DIALOG_TYPE_GENERIC = 2;

  int _dialogType;
  int get dialogType => _dialogType;

  String message = "";

  DialogEvent._internal(): super("");

  DialogEvent.dialogWithMessage(this._dialogType, this.message) : super(message);

  DialogEvent.dialogWithOutMessage(this._dialogType) : super("");

}


class RouteToAnotherScreen extends UIEvent {
  String _routeName;
  String get routeName => _routeName;
  RouteToAnotherScreen(this._routeName) : super("");
}

class LoadingScreenUiEvent extends UIEvent {
  bool _makeVisible = false;
  bool get isVisible => _makeVisible;
  LoadingScreenUiEvent(this._makeVisible) : super(_makeVisible);
}