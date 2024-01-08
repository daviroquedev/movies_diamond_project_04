import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/auth/store/auth_google_store.dart';

class AppBarLogged extends StatelessWidget implements PreferredSizeWidget {
  const AppBarLogged({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            color: Colors.white,
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final NavigatorState navigator = Navigator.of(context);

            if (Modular.to.path.contains('/movies/detailed')) {
              print('RETORNOU A TELA');
              return Modular.to.pop();
            }

            final GoogleSignIn googleSignIn = GoogleSignIn();
            final UserStore userStore = Modular.get<UserStore>();

            await googleSignIn.signOut();
            userStore.logout();

            print('DESLOGADO: ');
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
