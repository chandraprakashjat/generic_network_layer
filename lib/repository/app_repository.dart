import '../models/model.dart';
import '../util/path_constant.dart';
import './network_layer/network_layer.dart';

class AppRepository {
  AppRepository._();

  static final AppRepository _instance = AppRepository._();

  factory AppRepository() {
    return _instance;
  }

  Future<NetworkResponse> getMovieList() async {
    var networkRequest = const NetworkRequest(
        networkRequestType: NetworkRequestType.GET,
        path: PathConstant.mvList,
        networkRequestBody: NetworkRequestBody.empty());

    var response = NetworkService(baseUrl: PathConstant.mvBaseUrl);

    NetworkResponse dataResponse =
        await response.execute(networkRequest, Model.getMovieList);

    return dataResponse;
  }
}
