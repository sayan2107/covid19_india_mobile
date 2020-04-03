import 'package:corona_trac_helper/src/infra/network/model/api_error_model.dart';

class ParsedResponse<T> {
  bool _hasError = false;
  bool get hasError => _hasError;

  bool _hasData = false;
  bool get hasData => _hasData;

  T _data;
  T get data => _data;

  ApiErrorModel _errorModel;
  ApiErrorModel get error => _errorModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ParsedResponse.addData(this._data) {
    _hasData = true;
    _hasError = false;
    _isLoading = false;
  }

  ParsedResponse.addError(this._errorModel) {
    _hasError = true;
    _hasData = false;
    _isLoading = false;
  }

  ParsedResponse.isLoading(bool isLoadingState) {
    _isLoading = isLoadingState;
  }

  ParsedResponse._internal();
}