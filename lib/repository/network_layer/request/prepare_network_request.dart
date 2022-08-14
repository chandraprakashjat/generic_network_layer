import 'package:dio/dio.dart';
import 'package:network_layer/models/model.dart';

import 'network_request.dart';

class PreparedNetworkRequest {
  PreparedNetworkRequest(this.dio, this.networkRequest, this.header,
      this.onSendProgress, this.onRcvProgress, this.parser);

  final Dio dio;
  final NetworkRequest networkRequest;
  final Map<String, dynamic> header;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onRcvProgress;
  final Model Function(dynamic) parser;
}
