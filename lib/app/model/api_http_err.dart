

enum ApiHttpErrorType {
  Default,
  Auth,
  BadRequest,
  NotFound,
  BadParamHeader,
  NetWork,
  Timeout,
  Cancel,
}

class ApiHttpError {

  ApiHttpErrorType type;
  String? msg;

  ApiHttpError(this.type,this.msg);

}