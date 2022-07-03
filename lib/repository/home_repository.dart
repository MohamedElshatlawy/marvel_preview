import '../network/networkCallback/network_callback.dart';
import '../network/services_urls.dart';
import '../utils/enums.dart';

class HomeRepository {
  Future<Map<String, dynamic>> getCharactersRequest(
      {required int offset, required int limit}) async {
    return await NetworkCall.makeCall(
      endPoint: ServicesURLs.characters,
      method: HttpMethod.GET,
      urlExist: false,
      queryParams: {
        'offset': '$offset',
        'limit': '$limit',
      },
    );
  }

  Future<Map<String, dynamic>> getCharactersDetailsRequest(
      {required String endPoint}) async {
    return await NetworkCall.makeCall(
      endPoint: endPoint,
      urlExist: true,
      method: HttpMethod.GET,
      queryParams: {},
    );
  }
}
