import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as dio_lib;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:safeline_ku/common/util/service_response.dart';

class HttpService extends GetxService {
  static HttpService get to => Get.find();
  static const String _baseUrl = 'https://d29cb15c-e309-44ed-9ea7-cb7577a0c6e5.mock.pstmn.io';

  Future<ServiceResponse> asyncGet({required String url, Map<String, dynamic>? params, bool isAuth = true}) async {
    dio_lib.Dio dio = dio_lib.Dio();
    dio_lib.Response response;
    try {
      response = await dio.get("$_baseUrl$url", queryParameters: params ?? {});
      if (response.isSuccesful) {
        return ServiceResponse(result: true, value: response.data);
      } else {
        return ServiceResponse(result: false, value: response.data);
      }
    } on dio_lib.DioException catch (e) {
      if (e.response != null) {
        Logger().e(e.response!);
        return ServiceResponse(result: false, value: e.response!.data, errorMsg: e.message ?? '');
      } else {
        return ServiceResponse(result: false, value: e.message);
      }
    }
  }
}

extension ResponseExtension on dio_lib.Response {
  bool get isSuccesful => statusCode == 200 || statusCode == 204; //204 no content
}
