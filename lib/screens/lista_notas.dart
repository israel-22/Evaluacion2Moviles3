import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'detalles_notas.dart';

void main() => runApp(ListaNotasScreen());


class ListaNotasScreen extends StatefulWidget {
  @override
  _ListaNotasScreenState createState() => _ListaNotasScreenState();
}

class _ListaNotasScreenState extends State<ListaNotasScreen> {
  final DatabaseReference _notasRef = FirebaseDatabase.instance.ref("notas");
  List<Map<String, dynamic>> _notasList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadNotas();
  }

  void _loadNotas() {
    _notasRef.onValue.listen((event) {
      try {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          setState(() {
            _notasList = [];
            data.forEach((key, value) {
              if (value is Map) {
                _notasList.add({
                  "id": key,
                  "titulo": value['titulo'] ?? 'Sin título',
                  "descripcion": value['descripcion'] ?? 'Sin descripción',
                  "precio": value['precio'] ?? 0,
                });
              }
            });
            isLoading = false;
          });
        } else {
          setState(() {
            _notasList = [];
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = 'Error al cargar notas: ${e.toString()}';
          isLoading = false;
        });
      }
    }, onError: (error) {
      setState(() {
        errorMessage = 'Error en la conexión: $error';
        isLoading = false;
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : _notasList.isEmpty
                  ? Center(child: Text('No hay notas disponibles.'))
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
