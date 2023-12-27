import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/view/screen/auth_page.dart';
import 'package:movies_diamond_project_03/app/modules/home/home_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/movies_module.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/movies_page.dart';
import 'package:movies_diamond_project_03/app/modules/menu/menu_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';
import 'package:movies_diamond_project_03/app/modules/perfil/perfil_page.dart';

// responsavel pela rota e pela sistema de injeção de depedencias
class AppModule extends Module {
  @override
  void binds(i) {
    // i.addSingleton(MoviesService.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    r.module('/movies/', module: MoviesModule());
    r.child('/auth', child: (context) => AuthPage());
  }
}
