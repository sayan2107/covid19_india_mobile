class ApiErrorModel {
  int _statusCode = 0;
  int get statusCode => _statusCode;

  String _message;
  String get message => _message;

  Exception exception;

  ApiErrorModel(this._statusCode, this._message, [this.exception]);

  ApiErrorModel.fromJson(Map<String, dynamic> parsedJson) :
        _message = parsedJson['message'];

}