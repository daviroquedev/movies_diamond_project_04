// https://developer.themoviedb.org/reference/authentication-create-guest-session
// https://api.themoviedb.org/3/authentication/guest_session/new _

import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<String> requestToken(String apiKey) async {
    try {
      final Response response = await _dio.get(
        'https://api.themoviedb.org/3/authentication/token/new',
        queryParameters: {'api_key': apiKey},
      );

      if (response.statusCode == 200) {
        return response.data['request_token']; // Retornar apenas o token
      } else {
        throw Exception('Falha ao criar o request_token');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao criar o request_token');
    }
  }
}
