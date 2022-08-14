import 'request_body.dart';

enum NetworkRequestType { GET, POST, PUT, PATCH, DELETE }

class NetworkRequest {
  const NetworkRequest(
      {required this.networkRequestType,
      required this.path,
      required this.networkRequestBody,
      this.queryParameter,
      this.headers});
  final NetworkRequestType networkRequestType;
  final String path;
  final NetworkRequestBody networkRequestBody;

  final Map<String, dynamic>? queryParameter;
  final Map<String, dynamic>? headers;
}
