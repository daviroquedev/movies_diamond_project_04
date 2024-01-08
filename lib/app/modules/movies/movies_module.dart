import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/auth_module.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movie_detailed_service.dart';
import 'package:movies_diamond_project_03/app/modules/movies/store/movies_store.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/movie_detailed_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/movies_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';

class MoviesModule extends Module {
  @override
  Future<void> binds(i) async {
    // print(i);
    i.addInstance(Dio());
    i.addSingleton(MoviesService.new);
    i.addSingleton(MoviesStore.new);
    i.addSingleton(MovieDetailsService.new);
    // i.addSingleton(UserStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => MoviesScreen());
    r.child('/detailed/:id', child: (context) {
      final movie = r.args.data
          as MoviesModels; // Obtendo o objeto passado como argumento

      return MovieDetailsPage(movie: movie);
    });
    // r.module('/auth/', module: AuthModule());
  }
}

// @override
// final List<Bind> binds = [
//   Bind.singleton((i) => MovieService()),
// ];

// responsavel pela rota e pela sistema de injeção de depedencias
// class AppModule extends Module {
//   @override
//   void binds(i) {}

//   @override
//   void routes(r) {
//     r.child('/', child: (context) => HomePage());
//     r.child('/movies', child: (context) => MoviesScreen());
//     r.child('/auth', child: (context) => AuthPage());
//   }
// }
