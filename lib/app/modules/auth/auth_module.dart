import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/moviedbService/moviedb_auth_service.dart';
import 'package:movies_diamond_project_03/app/modules/auth/view/screen/auth_page.dart';

class AuthModule extends Module {
  @override
  Future<void> binds(i) async {
    i.addInstance(Dio());
    i.addSingleton(AuthApi.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => AuthPage());
  }
}
