import 'package:evaluacion2/screens/nueva_nota.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/lista_notas.dart';
import 'screens/detalles_notas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para convertir la respuesta JSON
import 'dart:async';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comentarios de Series',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/registro': (context) => RegistroScreen(),
        '/lista_notas': (context) => ListaNotasScreen(),
        '/nueva_nota': (context) => NuevaNotaScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/lista_series') {
          final nota = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DetallesNotaScreen(nota: nota),
          );
        }
        return null;
      },
    );
  }
}
