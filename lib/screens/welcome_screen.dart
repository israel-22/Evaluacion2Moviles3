import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Bienvenido!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text('Iniciar Sesión'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/registro'),
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
