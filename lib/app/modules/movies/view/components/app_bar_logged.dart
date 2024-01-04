import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
          onPressed: () {
            final NavigatorState navigator = Navigator.of(context);
            if (navigator.canPop()) {
              Modular.to.pop();
            } else {
              Modular.to.navigate('/');
            }
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
