import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/auth_module.dart';
import 'package:movies_diamond_project_03/app/modules/auth/store/auth_google_store.dart';
import 'package:movies_diamond_project_03/app/modules/auth/view/screen/auth_page.dart';
import 'package:movies_diamond_project_03/app/modules/home/view/home_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/movies_module.dart';

// responsavel pela rota e pela sistema de injeção de depedencias
class AppModule extends Module {
  // void init(context) async {
  //   await Firebase.initializeApp(); // Inicialize o Firebase aqui
  // }

  @override
  void binds(i) {
    i.addSingleton(UserStore.new);
    i.addInstance(Firebase.initializeApp());
    i.addInstance(FirebaseFirestore);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    r.module('/auth/', module: AuthModule());
    r.module('/movies/', module: MoviesModule());
    r.child('/auth', child: (context) => AuthPage());
  }
}
