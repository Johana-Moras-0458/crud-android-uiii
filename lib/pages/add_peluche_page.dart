import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddPeluchePage extends StatefulWidget {
  const AddPeluchePage({super.key});

  @override
  State<AddPeluchePage> createState() => _AddPeluchePageState();
}

class _AddPeluchePageState extends State<AddPeluchePage> {
  final Map<String, TextEditingController> controllers = {
    "id_peluche": TextEditingController(),
    "id_proveedor": TextEditingController(),
    "id_sucursal": TextEditingController(),
    "nombre": TextEditingController(),
    "color": TextEditingController(),
    "precio": TextEditingController(),
    "tamaño": TextEditingController(),
    "tipo_de_tela": TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Peluche")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ...controllers.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: entry.value,
                decoration: InputDecoration(
                  labelText: entry.key,
                  border: const OutlineInputBorder(),
                ),
              ),
            )),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = {
                  for (var entry in controllers.entries) entry.key: entry.value.text,
                  "precio": double.tryParse(controllers["precio"]!.text) ?? 0.0,
                };
                await addPeluche(data);
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
