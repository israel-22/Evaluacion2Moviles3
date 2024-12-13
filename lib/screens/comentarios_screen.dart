import 'package:flutter/material.dart';

class ComentariosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comentarios')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menú', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('Lista de Series'),
              onTap: () => Navigator.pushNamed(context, '/lista_series'),
            ),
          ],
        ),
      ),
      body: Center(child: Text('Aquí irán los comentarios')),
    );
  }
}
