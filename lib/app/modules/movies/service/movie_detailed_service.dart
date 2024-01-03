import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';

class MovieDetailsService {
  late MoviesModels _selectedMovie;

  void setSelectedMovie(MoviesModels movie) {
    _selectedMovie = movie;
  }

  getSelectedMovie() {
    return _selectedMovie;
  }
}
