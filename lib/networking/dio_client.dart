import 'package:dio/dio.dart';
import 'package:ecom/networking/api_endpoints.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options
      ..baseUrl = APIEndpoints.BaseUrl
      // ..connectTimeout = const Duration(seconds: 10)
      // ..receiveTimeout = const Duration(seconds: 10)
      ..headers = {
        'Content-Type': 'application/json',
      };
  }

  Future<Response> get(String endPoint) async {
    try {
      final response = await _dio.get(endPoint);
      return response;
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> post(String endPoint, dynamic data) async {
    try{
      final response = await _dio.post(endPoint, data: data);
      return response;
    } on DioException catch (e) {
      return Future.error(e);
    }
  }
}
