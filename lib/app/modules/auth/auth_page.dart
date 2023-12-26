import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Modular.to.navigate('/'),
                child: const Text('VOLTAR'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  // Implement your Google login logic here
                },
                icon: const Icon(Icons.account_circle,
                    color: Color.fromARGB(255, 98, 95, 248)),
                label: const Text('Login com Google'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  side:
                      const BorderSide(color: Color.fromARGB(255, 54, 2, 241)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
