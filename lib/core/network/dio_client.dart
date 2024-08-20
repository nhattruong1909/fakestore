import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fakestore/core/constants/Constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late final Dio _dio;
  DioClient()
      : _dio = Dio(BaseOptions(
            baseUrl: Constant.baseUrl,
            receiveTimeout: Duration(seconds: 30),
            connectTimeout: Duration(seconds: 30),
            responseType: ResponseType.json))
          ..interceptors.add(PrettyDioLogger(
            compact: false,
            logPrint: (object) => log(object.toString(), name: 'Fake Store'),
          ));
  Future<Response<dynamic>> get(String url,
      {Map<String, dynamic>? queryParameters,
      Options? option,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await _dio.get(url,
          queryParameters: queryParameters,
          options: option,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response<dynamic>> post(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? option,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      ProgressCallback? onSendProgress}) async {
    try {
      final response = await _dio.post(url,
          data: data,
          queryParameters: queryParameters,
          options: option,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response<dynamic>> put(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? option,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      ProgressCallback? onSendProgress}) async {
    try {
      final response = await _dio.put(url,
          data: data,
          queryParameters: queryParameters,
          options: option,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response<dynamic>> patch(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? option,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      ProgressCallback? onSendProgress}) async {
    try {
      final response = await _dio.patch(url,
          data: data,
          queryParameters: queryParameters,
          options: option,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
