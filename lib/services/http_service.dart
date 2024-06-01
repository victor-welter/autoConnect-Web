// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:dio/dio.dart';

import '../utils/response_validate.dart';

class HttpService {
  static const String URL_BASE = 'https://sharp-manatee-divine.ngrok-free.app';

  ///Responsável por fazer requisições do tipo `GET`
  ///
  ///Utilize a propriedade [url] quando desejar usar um link completo, sem interferências da base url selecionada
  static Future<dynamic> get({
    required String rota,
    Map? params,
    Map? headers,
    bool validResponse = true,
  }) async {
    if (headers != null) {
      headers = {};
    }

    try {
      Response response = await Dio().get(
        '$URL_BASE$rota',
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
    required String rota,
    dynamic body,
    Map? params,
    Map? headers,
    bool validResponse = true,
  }) async {
    try {
      Response response = await Dio().post(
        '$URL_BASE$rota',
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
        ResponseValidate.validateDioError(error: err, rota: rota);
      }
    } catch (_) {
      rethrow;
    }
  }
}
