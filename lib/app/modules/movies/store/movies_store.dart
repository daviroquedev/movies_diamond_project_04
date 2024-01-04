import 'package:mobx/mobx.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';

part 'movies_store.g.dart';

class MoviesStore = _MoviesStore with _$MoviesStore;

abstract class _MoviesStore with Store {
  final MoviesService _moviesService;

  _MoviesStore(this._moviesService);

  @observable
  ObservableFuture<dynamic>? movieDetailsFuture;

  @action
  Future<dynamic> fetchMovieDetails(int movieId) async {
    movieDetailsFuture =
        ObservableFuture(_moviesService.fetchMovieDetails(movieId));
    return await movieDetailsFuture!;
  }

  @observable
  ObservableFuture<List<dynamic>>? popularMoviesFuture;

  @action
  Future<List<dynamic>> fetchPopularMovies() async {
    popularMoviesFuture = ObservableFuture(_moviesService.fetchPopularMovies());
    return await popularMoviesFuture!;
  }

  @observable
  ObservableFuture<List<dynamic>>? randomMoviesFuture;

  @action
  Future<List<dynamic>> fetchRandomMovies() async {
    randomMoviesFuture = ObservableFuture(_moviesService.fetchRandomMovies());
    return await randomMoviesFuture!;
  }

  @observable
  ObservableFuture<List<dynamic>>? oldMoviesFuture;

  @action
  Future<List<dynamic>> fetchOldMovies() async {
    oldMoviesFuture = ObservableFuture(_moviesService.fetchOldMovies());
    return await oldMoviesFuture!;
  }

  @observable
  ObservableFuture<List<dynamic>>? searchMoviesFuture;

  @action
  Future<List<dynamic>> searchMovies(String query) async {
    searchMoviesFuture = ObservableFuture(_moviesService.searchMovies(query));
    return await searchMoviesFuture!;
  }

  @observable
  ObservableFuture<List<dynamic>>? topRatedMoviesFuture;

  @action
  Future<List<dynamic>> fetchTopRatedMovies() async {
    topRatedMoviesFuture =
        ObservableFuture(_moviesService.fetchTopRatedMovies());
    return await topRatedMoviesFuture!;
  }
}
