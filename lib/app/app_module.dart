import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/auth_module.dart';
import 'package:movies_diamond_project_03/app/modules/auth/view/screen/auth_page.dart';
import 'package:movies_diamond_project_03/app/modules/home/view/home_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';

import 'package:movies_diamond_project_03/app/modules/movies/movies_module.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movie_detailed_service.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/movie_detailed_page.dart';

// responsavel pela rota e pela sistema de injeção de depedencias
class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    r.module('/movies/', module: MoviesModule());
    r.child('/auth', child: (context) => AuthPage());
    r.module('/auth/', module: AuthModule());
  }
}
