import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Para actualizar la nota en Firebase
//Navigator.pushNamed(context, '/nueva_nota'); // Navegar a la pantalla de nueva nota
class DetallesNotaScreen extends StatefulWidget {
  final Map<String, dynamic> nota; // Recibe la nota seleccionada

  DetallesNotaScreen({required this.nota});

  @override
  _DetallesNotaScreenState createState() => _DetallesNotaScreenState();
}

class _DetallesNotaScreenState extends State<DetallesNotaScreen> {
  final DatabaseReference _notasRef = FirebaseDatabase.instance.ref("notas"); // Referencia a la base de datos en Firebase

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tituloController.text = widget.nota['titulo'];
    _descripcionController.text = widget.nota['descripcion'];
    _precioController.text = widget.nota['precio'].toString();
  }

  void _actualizarNota() {
    final updatedNota = {
      'titulo': _tituloController.text,
      'descripcion': _descripcionController.text,
      'precio': double.parse(_precioController.text),
    };

    _notasRef.child(widget.nota['id']).update(updatedNota); // Actualizar nota en Firebase
    Navigator.pop(context); // Regresar a la pantalla anterior
  }

  void _eliminarNota() {
    _notasRef.child(widget.nota['id']).remove(); // Eliminar nota de Firebase
    Navigator.pop(context); // Regresar a la pantalla anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Nota'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _eliminarNota, // Eliminar nota
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _actualizarNota, // Actualizar la nota
              child: Text('Actualizar Nota'),
            ),
          ],
        ),
        
      ),
    );
  }
}
