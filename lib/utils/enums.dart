import 'enumeration.dart';

class HttpMethod extends Enum {
  HttpMethod(value) : super(value);

  static final HttpMethod GET = HttpMethod('GET');
  static final HttpMethod POST = HttpMethod('POST');
  static final HttpMethod PUT = HttpMethod('PUT');
  static final HttpMethod DELETE = HttpMethod('DELETE');
}

class NetworkStatusCodes extends Enum {
  NetworkStatusCodes(value) : super(value);

  static final UnAuthorizedUser = NetworkStatusCodes(401);
  static final BadRequest = NetworkStatusCodes(400);
  static final ServerInternalError = NetworkStatusCodes(500);
  static final OK_200 = NetworkStatusCodes(200);
  static final NoContent = NetworkStatusCodes(204);
}
