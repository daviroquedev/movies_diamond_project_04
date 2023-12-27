import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MoviesService {
  final String apiKey = '9598d00230dc09769db0762336124969';
  final Dio _dio;

  MoviesService(this._dio);

  Future<dynamic> fetchMovieDetails(int movieId) async {
    try {
      final Response response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$movieId',
        queryParameters: {'api_key': apiKey},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Falha ao carregar os detalhes do filme');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao buscar os detalhes do filme');
    }
  }

  Future<List<dynamic>> fetchPopularMovies() async {
    try {
      final Response response = await _dio.get(
        'https://api.themoviedb.org/3/movie/popular',
        queryParameters: {'api_key': apiKey},
      );

      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        throw Exception('Falha ao carregar os filmes populares');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao buscar os filmes populares');
    }
  }

  Future<List<dynamic>> fetchRandomMovies() async {
    try {
      final Response response = await _dio.get(
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=2&sort_by=popularity.desc',
        queryParameters: {'api_key': apiKey},
      );

      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        throw Exception('Falha ao carregar os filmes RANDOM');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao buscar os filmes RANDOMMM');
    }
  }

  Future<List<dynamic>> fetchOldMovies() async {
    try {
      final Response response = await _dio.get(
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=primary_release_date.asc',
        queryParameters: {'api_key': apiKey},
      );

      if (response.statusCode == 200) {
        print('olddddddddddddddd${response.data['results']}');
        return response.data['results'];
      } else {
        throw Exception('Falha ao carregar os filmes RANDOM');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao buscar os filmes RANDOMMM');
    }
  }
}
