import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movie_detailed_service.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/movie_detailed_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:shimmer/shimmer.dart';

class MovieCard extends StatelessWidget {
  final MoviesModels movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final movieDetailsService = Modular.get<MovieDetailsService>();
        movieDetailsService.setSelectedMovie(movie);

        Modular.to.pushNamed('/movies/detailed/${movie.id}', arguments: movie);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: _buildMovieImage(),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieImage() {
    print(movie);
    return Image.network(
      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
              height: 180,
            ),
          );
        }
      },
      fit: BoxFit.cover,
      height: 180,
    );
  }
}

// Exemplo de página de descrição do filme (crie conforme sua estrutura)
class MovieDescriptionPage extends StatelessWidget {
  final MoviesModels movie;

  const MovieDescriptionPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implemente a estrutura da página de descrição do filme aqui
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Center(
        child: Text('Descrição do Filme: ${movie.title}'),
      ),
    );
  }
}
