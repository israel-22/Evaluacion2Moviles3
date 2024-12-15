import 'package:evaluacion2/screens/detalles_notas.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:evaluacion2/screens/detalles_notas.dart';

class ListaNotasScreen extends StatefulWidget {
  @override
  _ListaNotasScreenState createState() => _ListaNotasScreenState();
}

class _ListaNotasScreenState extends State<ListaNotasScreen> {
  final DatabaseReference _notasRef = FirebaseDatabase.instance.ref("notas");
  late DatabaseEvent _notasEvent;
  List<Map<dynamic, dynamic>> _notasList = [];

  @override
  void initState() {
    super.initState();
    _notasRef.onValue.listen((event) {
      setState(() {
        _notasList = [];
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          data.forEach((key, value) {
            _notasList.add({
              "id": key,
              "titulo": value['titulo'],
              "descripcion": value['descripcion'],
              "precio": value['precio'],
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Notas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/registro');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menú', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('Lista de Notas'),
              onTap: () => Navigator.pushNamed(context, '/lista_series'),
            ),
          ],
        ),
      ),
      body: _notasList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _notasList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notasList[index]["titulo"]),
                  subtitle: Text(_notasList[index]["descripcion"]),
                  trailing: Text("\$${_notasList[index]["precio"]}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesNotaScreen(
                          nota: _notasList[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
