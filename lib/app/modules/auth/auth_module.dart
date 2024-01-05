import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/googleAuth/google_auth_sign_in.dart';

class AuthModule extends Module {
  @override
  Future<void> binds(i) async {
    // print(i);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => SignInScreen());
  }
}
