import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = ''; // Para mostrar el error en caso de fallo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            errorMessage.isNotEmpty
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Registrar al usuario con Firebase
                  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Si el registro es exitoso, redirigir a la pantalla de login
                  Navigator.pushNamed(context, '/login');
                } on FirebaseAuthException catch (e) {
                  // Mostrar un mensaje de error si el registro falla
                  setState(() {
                    errorMessage = 'Error al registrar usuario: ${e.message}';
                  });
                }
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
