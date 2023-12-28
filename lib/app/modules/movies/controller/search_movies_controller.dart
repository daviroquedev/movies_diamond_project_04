import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';

class SearchDrawerController {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  Timer? debounce;

  void dispose() {
    searchController.dispose();
    debounce?.cancel();
  }

  void onSearchChanged() {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      if (searchController.text.length >= 3) {
        _searchMovies(searchController.text);
      }
    });
  }

  Future<void> _searchMovies(String query) async {
    try {
      final List<dynamic> results =
          await Modular.get<MoviesService>().searchMovies(query);
      searchResults = results;
    } catch (e) {
      print('Erro ao buscar filmes: $e');
    }
  }
}
