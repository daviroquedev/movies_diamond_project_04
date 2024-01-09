import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/googleAuth/google_auth_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/moviedbService/moviedb_auth_service.dart';
import 'package:movies_diamond_project_03/app/modules/auth/store/auth_google_store.dart';
import 'package:movies_diamond_project_03/app/modules/auth/view/screen/auth_page.dart';

class AuthModule extends Module {
  @override
  Future<void> binds(i) async {
    // i.addSingleton(UserStore.new);
    i.addInstance(Dio());
    i.addSingleton(AuthApi.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => AuthPage());
  }
}
