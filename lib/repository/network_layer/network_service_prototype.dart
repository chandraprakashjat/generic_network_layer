import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:network_layer/models/model.dart';

import 'request/network_request.dart';
import 'request/prepare_network_request.dart';
import 'response/network_response.dart';

class NetworkService {
  NetworkService({required this.baseUrl, dio, header})
      : _dio = dio,
        _header = header ?? {};
  final String baseUrl;
  Dio? _dio;
  final Map<String, dynamic> _header;

  Future<Dio> _getDefaultDioClient() async {
    //default header
    _header['content_type'] = 'application/json; charset=utf-8';

    final dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.headers = _header
      ..options.connectTimeout = 5000
      ..options.receiveTimeout = 20000;

    return dio;
  }

  void addBasicAuth(String accessToken) {
    _header['authorization'] = 'Bearer $accessToken';
  }

  Future<NetworkResponse<Model>> execute(
      NetworkRequest networkRequest, Model Function(dynamic) parser,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onRcvProgress}) async {
    _dio ??= await _getDefaultDioClient();

    final request = PreparedNetworkRequest(
        _dio!,
        networkRequest,
        {..._header, ...networkRequest.headers ?? {}},
        onSendProgress,
        onRcvProgress,
        parser);

    print('Prepare request');
    final result = await compute(executeRequest, request);

    return result;
  }

  Future<NetworkResponse<Model>> executeRequest(
    PreparedNetworkRequest request,
  ) async {
    print('Execute request');
    try {
      var data = request.networkRequest.networkRequestBody
          .whenOrNull(json: (data) => data, text: (data) => data);
      final response = await request.dio.request(request.networkRequest.path,
          data: data,
          queryParameters: request.networkRequest.queryParameter,
          onReceiveProgress: request.onRcvProgress,
          onSendProgress: request.onSendProgress,
          options: Options(
              headers: request.header,
              method: request.networkRequest.networkRequestType.name));

      //  print(response.data.toString());

      return NetworkResponse.ok(request.parser((response.data)));
    } on DioError catch (error) {
      final errorString = error.toString();

      print(errorString);

      switch (error.response?.statusCode) {
        case 400:
          return NetworkResponse.badRequest(errorString);
        case 401:
          return NetworkResponse.noAuth(errorString);
        case 403:
          return NetworkResponse.noAccess(errorString);
        case 404:
          return NetworkResponse.notFound(errorString);

        case 409:
          return NetworkResponse.conflict(errorString);

        default:
          return NetworkResponse.noData(errorString);
      }
    } catch (error) {
      return NetworkResponse.noData(error.toString());
    }
  }
}
