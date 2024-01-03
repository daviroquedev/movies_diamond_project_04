import 'package:flutter/material.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/row_movies_cards.dart';

Widget buildMovieSection(
    {required String title, required List<MoviesModels> movies}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 247, 247, 247),
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: movies.map((movie) => buildMovieCard(movie)).toList(),
        ),
      ),
    ],
  );
}

Widget buildMovieCard(MoviesModels movie) {
  return MovieCard(movie: movie);
}
