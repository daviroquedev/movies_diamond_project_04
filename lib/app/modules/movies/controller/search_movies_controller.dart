import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';

class SearchMoviesController {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  Timer? debounce;

  void initSearchListener(void Function(List<dynamic>) updateResults) {
    searchController.addListener(() {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 500), () {
        if (searchController.text.length >= 3) {
          searchMovies(searchController.text, updateResults);
        }
      });
    });
  }

  Future<void> searchMovies(
      String query, void Function(List<dynamic>) updateResults) async {
    try {
      final List<dynamic> results =
          await Modular.get<MoviesService>().searchMovies(query);
      updateResults(results);
    } catch (e) {
      print('Erro ao buscar filmes: $e');
    }
  }

  void dispose() {
    searchController.dispose();
    debounce?.cancel();
  }
}
