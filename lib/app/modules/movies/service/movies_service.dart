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
        print('RESPOBDE SE 1${response.data['results'][1]}');
        return response.data['results'];
      } else {
        throw Exception('Falha ao carregar os filmes populares');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao buscar os filmes populares');
    }
  }
}


// import 'package:dio/dio.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// class MoviesService extends Module {
//   final String apiKey = '9598d00230dc09769db0762336124969';
//   final Dio _dio;

//   MoviesService(this._dio);

//   Future<dynamic> fetchMovieDetails(int movieId) async {
//     try {
//       final Response response = await _dio.get(
//         'https://api.themoviedb.org/3/movie/$movieId',
//         queryParameters: {'api_key': apiKey},
//       );

//       print('dioooooooooooooooo1111 $_dio');

//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception('Falha ao carregar os detalhes do filme');
//       }
//     } catch (e) {
//       print('Erro: $e');
//       throw Exception('Erro ao buscar os detalhes do filme');
//     }
//   }

//   Future<List<dynamic>> fetchPopularMovies() async {
//     try {
//       final Response response = await _dio.get(
//         'https://api.themoviedb.org/3/movie/popular',
//         queryParameters: {'api_key': apiKey},
//       );
//       print('dioooooooooooooooo2222222222 $_dio');

//       if (response.statusCode == 200) {
//         print('RESPOBDE SE 1${response.data['results'][1]}');
//         return response.data['results'];
//       } else {
//         print('dioooooooooooooooo33333333 $_dio');
//         throw Exception('Falha ao carregar os filmes populares');
//       }
//     } catch (e) {
//       print('Erro: $e');
//       throw Exception('Erro ao buscar os filmes populares');
//     }
//   }
// }
