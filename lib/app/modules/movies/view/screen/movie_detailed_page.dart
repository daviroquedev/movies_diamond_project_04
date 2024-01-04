import 'package:flutter/material.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/app_bar_logged.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/star_rating.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/drawer_islogged.dart';

class MovieDetailsPage extends StatelessWidget {
  final MoviesModels movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLogged(),
      drawer: const SearchDrawer(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
              fit: BoxFit.cover,
              height: 470,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingStars(voteAverage: movie.voteAverage),
                      Text(
                        'Lançamento: ${movie.releaseDate}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
