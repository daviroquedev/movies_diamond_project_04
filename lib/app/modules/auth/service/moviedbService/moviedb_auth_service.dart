// https://developer.themoviedb.org/reference/authentication-create-guest-session
// https://api.themoviedb.org/3/authentication/guest_session/new _

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  Future<String> createSession(String apiKey, String requestToken) async {
    try {
      final Response response = await _dio.post(
        'https://api.themoviedb.org/3/authentication/session/new',
        queryParameters: {'api_key': apiKey},
        data: {'request_token': requestToken},
      );

      if (response.statusCode == 200) {
        return response.data['session_id'];
      } else {
        throw Exception('Falha ao criar o session_id');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao criar o session_id');
    }
  }

  // Future<void> requestUserPermission(String requestToken) async {
  //   final Uri url =
  //       Uri.parse('https://www.themoviedb.org/authenticate/$requestToken');

  //   print('REQUEST USER PERMISSION');

  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
}
