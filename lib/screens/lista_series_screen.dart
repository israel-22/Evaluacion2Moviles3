import 'package:flutter/material.dart';

class ListaSeriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Series')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menú', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('Comentarios'),
              onTap: () => Navigator.pushNamed(context, '/comentarios'),
            ),
          ],
        ),
      ),
      body: Center(child: Text('Aquí irá la lista de series')),
    );
  }
}
