// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../utils/request_utils.dart';
import '../utils/response_validate.dart';

class HttpService {
  static const String URL_BASE = kReleaseMode ? 'http://mobileconnect.abase.com.br:33102' : 'https://192.168.11.16:3030';

  ///Responsável por fazer requisições do tipo `GET`
  ///
  ///Utilize a propriedade [url] quando desejar usar um link completo, sem interferências da base url selecionada
  static Future<dynamic> get({
    required String? rota,
    String? url,
    Map? params,
    Map? headers,
    bool validResponse = true,
    bool useToken = true,
  }) async {
    try {
      String urlRequest;
      if (url == null) {
        urlRequest = '$URL_BASE$rota';
      } else {
        urlRequest = url;
      }

      final dio = Dio();

      if (useToken) {
        try {
          //Automaticamente adiciona o token a requisição
          headers ??= {}; //Caso seja nulo, cria um map vazio
          headers.addAll({HttpHeaders.authorizationHeader: await retornaJWT()});
        } catch (_) {}
      }

      if (headers != null) {
        headers.addAll({
          HttpHeaders.acceptHeader: 'application/json',
        });
      }

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          debugPrint('Certificate Failed');
          return true;
        };

        client.idleTimeout = const Duration(seconds: 60);

        client.connectionTimeout = const Duration(minutes: 2);

        return null;
      };

      Response response = await dio.get(
        urlRequest,
        queryParameters: params?.cast(),
        options: Options(
          headers: headers?.cast(),
          followRedirects: false,
          contentType: 'application/json',
          maxRedirects: 0,
          method: 'GET',
          validateStatus: (status) {
            return (status ?? 404) < 400;
          },
        ),
        onReceiveProgress: (progress, total) {},
      );

      if (validResponse) {
        ResponseValidate.validate(resp: response);
      }

      return response.data;
    } on DioError catch (err) {
      if (validResponse) {
        ResponseValidate.validateDioError(error: err, rota: rota);
      }
    } catch (_) {
      rethrow;
    }
  }

  ///Responsável por fazer requisições do tipo `POST`
  ///
  ///Utilize a propriedade [url] quando desejar usar um link completo, sem interferências da base url selecionada
  static Future<dynamic> post({
    required String? rota,
    String? url,
    dynamic body,
    Map? params,
    Map? headers,
    bool validResponse = true,
    bool useToken = true,
  }) async {
    try {
      String urlRequest;
      if (url == null) {
        urlRequest = '$URL_BASE$rota';
      } else {
        urlRequest = url;
      }

      final dio = Dio();

      if (useToken) {
        try {
          //Automaticamente adiciona o token a requisição
          headers ??= {}; //Caso seja nulo, cria um map vazio
          headers.addAll({HttpHeaders.authorizationHeader: await retornaJWT()});
        } catch (_) {}
      }

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          debugPrint('Certificate Failed');
          return true;
        };

        client.idleTimeout = const Duration(seconds: 60);

        client.connectionTimeout = const Duration(minutes: 2);

        return null;
      };

      Response response = await dio.post(
        urlRequest,
        data: body,
        queryParameters: params?.cast(),
        options: Options(
          headers: headers?.cast(),
          followRedirects: false,
          contentType: 'application/json',
          maxRedirects: 0,
          method: 'POST',
          validateStatus: (status) {
            return (status ?? 404) < 400;
          },
        ),
        onReceiveProgress: (progress, total) {},
      );

      if (validResponse) {
        ResponseValidate.validate(resp: response);
      }

      return response.data;
    } on DioError catch (err) {
      if (validResponse) {
        ResponseValidate.validateDioError(error: err, rota: rota!);
      }
    } catch (_) {
      rethrow;
    }
  }

  ///Faz uma requisição `GET` para download de um arquivo
  ///
  ///Utilize a propriedade [url] quando desejar usar um link completo, sem interferências da base url selecionada na tela de login
  static Future<void> downloadFile({
    required String? rota,
    required File file,
    String? url,
    dynamic body,
    Map? params,
    Map? headers,
    String? method = 'GET',
  }) async {
    try {
      String urlRequest;
      if (url == null) {
        urlRequest = '$URL_BASE$rota';
      } else {
        urlRequest = url;
      }

      final dio = Dio();

      await dio.download(
        urlRequest,
        file.path,
        data: body,
        queryParameters: params?.cast(),
        options: Options(
          headers: headers?.cast(),
          contentType: 'application/octet-stream',
          responseType: ResponseType.bytes,
          method: method,
          validateStatus: (status) {
            return (status ?? 404) < 400;
          },
        ),
        deleteOnError: true,
        onReceiveProgress: (progress, total) {},
      );
    } on DioError catch (err) {
      ResponseValidate.validateDioError(error: err, rota: rota);
    } catch (_) {
      rethrow;
    }
  }
}
