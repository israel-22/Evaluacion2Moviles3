import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Para interactuar con Firebase

class NuevaNotaScreen extends StatefulWidget {
  @override
  _NuevaNotaScreenState createState() => _NuevaNotaScreenState();
}

class _NuevaNotaScreenState extends State<NuevaNotaScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  
  final DatabaseReference _notasRef = FirebaseDatabase.instance.ref("notas"); // Referencia a la base de datos de Firebase

  void _guardarNota() {
    final String titulo = _tituloController.text;
    final String descripcion = _descripcionController.text;
    final double precio = double.tryParse(_precioController.text) ?? 0.0;

    if (titulo.isNotEmpty && descripcion.isNotEmpty && precio > 0) {
      // Crear un nuevo registro de nota
      final newNota = {
        'titulo': titulo,
        'descripcion': descripcion,
        'precio': precio,
      };

      _notasRef.push().set(newNota); // Guardar la nueva nota en Firebase

      // Limpiar los campos
      _tituloController.clear();
      _descripcionController.clear();
      _precioController.clear();

      // Volver a la pantalla anterior
      Navigator.pop(context);
    } else {
      // Mostrar mensaje de error si los campos están vacíos
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, completa todos los campos correctamente.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Nota'),
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
              onPressed: _guardarNota, // Función para guardar la nota
              child: Text('Guardar Nota'),
            ),
          ],
        ),
      ),
    );
  }
}
